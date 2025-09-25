debImport "-sv" "-f" "filelist.f"
debLoadSimResult /home/pcs/Documents/Aditya_data/minor_project/dump1.fsdb
wvCreateWindow
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "top.i2s_intf" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "top.intf" -win $_nTrace1
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
verdiWindowResize -win $_Verdi_1 "8" "31" "879" "741"
wvSelectGroup -win $_nWave2 {G2}
verdiSetActWin -win $_nWave2
wvScrollUp -win $_nWave2 8
wvZoomAll -win $_nWave2
wvScrollUp -win $_nWave2 6
wvScrollDown -win $_nWave2 2
