<?php
require "include/bittorrent.php";
dbconn();
require_once(get_langfile_path());
loggedinorreturn();
parked();
$id = $_GET["id"];
if (get_user_class() < $viewnfo_class || !is_valid_id($id) || $enablenfo_main != 'yes')
	permissiondenied();

$sql = new_mysqli();
$query = $sql->prepare("SELECT `name`, `nfo` FROM `torrents` WHERE `id` = ?");
$query->bind_param("i", $id);
$query->execute();
$query->bind_result($torrent_name, $torrent_nfo);

$query->fetch() or die($lang_viewnfo['std_puke']);
$sql->close();

//error_reporting(E_ERROR | E_WARNING | E_PARSE | E_NOTICE);

// Download nfo file
if(isset($_GET['download']) && (((int)$_GET['download']) == 1)){
	$nfoinfo = $torrent_nfo; //blob
	//build header
	header("Cache-Control: public, must-revalidate");
	header("Content-Type: application/octet-stream");
	//header("Content-Length: " .(string)(filesize($myFile)) );
	header('Content-Disposition: attachment; filename="'.$id.'.nfo"');
	echo $nfoinfo;
	header("Content-Transfer-Encoding: binary\n");
	return;
}

// view might be one of: "magic", "latin-1", "strict" or "fonthack"
$view = "";
if (isset($_GET["view"])) {
	$view = unesc($_GET["view"]);
}
else {
	$view = "magic"; // default behavior
}

$nfo = "";

if ($view == "latin-1" || $view == "fonthack") {
	// Do not convert from ibm-437, read bytes as is.
	// NOTICE: TBSource specifies Latin-1 encoding in include/bittorrent.php:
	// stdhead()
	$nfo = htmlspecialchars($torrent_nfo, ENT_COMPAT, "ISO-8859-1");
}
else {
	
	// Convert from ibm-437 to html unicode entities.
	// take special care of Swedish letters if in magic view.
	$nfo = code($torrent_nfo, $view == "magic");
}

stdhead($lang_viewnfo['head_view_nfo']);

?>
<?= $lang_viewnfo['text_nfo_for'] ?>
<a href="details.php?id=<?= $id ?>"><?= htmlspecialchars($torrent_name) ?></a>
<a href="viewnfo.php?id=<?= $id ?>&download=1"><?= $lang_viewnfo['text_download'] ?></a>

<style type="text/css">

	/* 使用 MS LineDraw 作为修正字体 */
	.font-1 {
		font-size: 10pt;
		font-family: 'MS LineDraw', 'Terminal', monospace;
	}

	/* 标准字体 */
	.font-2 {
		font-size: 10pt;
		font-family: 'Courier New', monospace;
	}
</style>


<table border="1" cellspacing="0" cellpadding="10" align="center">
	<tr>
		<?php /*<td align="center" width="25%">
		<a href="viewnfo.php?id=<?= $id?>&view=fonthack"
		title="Teckensnittshack: Anv�nder nagon av teckensnitten MS LineDraw eller Terminal"><b>Teckensnittshack</b></a></td>*/?>
		<td align="center" width="50%">
			<a href="viewnfo.php?id=<?= $id?>&view=magic" title="<?= $lang_viewnfo['title_dos_vy'] ?>">
				<b><?= $lang_viewnfo['text_dos_vy'] ?></b>
			</a>
		</td>
		<td align="center" width="50%">
			<a href="viewnfo.php?id=<?= $id?>&view=latin-1" title="<?= $lang_viewnfo['title_windows_vy']?>">
				<b><?= $lang_viewnfo['text_windows_vy'] ?></b>
			</a>
		</td>
		<?php /*<td align="center" width="25%">
		<a href="viewnfo.php?id=<?= $id?>&view=strict"
		title="Strikt: Visar nfo-filen som den ser ut i teckentabellen IBM-437">
		<b>Strikt DOS-vy</b></a></td>*/?>
	</tr>
	<tr>
		<td colspan="3">
			<table border="1" cellspacing="0" cellpadding="5">
				<tr>
					<td class="text">
						<?php
													
						// -- About to output NFO data
						
						// Please notice: MS LineDraw's glyphs are included in the Courier New font
						// as of Courier New version 2.0, but uses the correct mappings instead.
						// http://support.microsoft.com/kb/q179422/
						
						$font = ($view == "fonthack") ? "font-1" : "font-2";

						?>
						<pre class="<?= $font ?>"><?= format_urls($nfo) ?></pre>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<?php
stdfoot();
