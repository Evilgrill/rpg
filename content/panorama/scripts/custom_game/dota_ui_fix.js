(function() {
    var base = $.GetContextPanel().GetParent().GetParent().GetParent();
    var kdaPanel = base.FindChildTraverse('quickstats');
    kdaPanel.style.visibility = "collapse";
    var killCam = base.FindChildTraverse('KillCam');
    killCam.style.visibility = "collapse";
    var minimapButtons = base.FindChildTraverse('GlyphScanContainer');
    minimapButtons.style.visibility = "collapse";
    var minimapSkin = base.FindChildTraverse('HUDSkinMinimap');
    minimapSkin.style.visibility = "collapse";
    var minimapPanel = base.FindChildTraverse('minimap_block');
    minimapPanel.style.borderColor = "#FF0000FF";
    minimapPanel.style.border = "1px solid gray";
    minimapPanel.style.borderRadius = "10px";
    minimapPanel.style.width = "260px";
    minimapPanel.style.height = "260px";
    minimapPanel.style.backgroundImage = "url('s2r://panorama/images/backgrounds/gallery_background_png.vtex')";
    var minimap = base.FindChildTraverse('minimap');
    minimap.style.width = "245px";
    minimap.style.height = "245px";
    minimap.style.borderRadius = "10px";
})();