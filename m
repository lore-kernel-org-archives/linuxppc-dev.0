Date: Mon, 31 Jan 2000 17:01:43 -0500
From: sat <satadru@umich.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: error in vger 2.2 kernel make dep
Message-ID: <150331497.949338103@nic-c17-233.mw.mediaone.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="==========150348346=========="
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--==========150348346==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This is the output I get when doing a make dep:
Is this an error that neds to be fixed in the tree, or is it on my end
alone?

I think that maybe the text "radio" got replaced with "rio"?


make -C char fastdep
make[4]: Entering directory
`/mnt/ibm/sin/src/kernel/linux.vger/drivers/char'
/usr/src/linux/scripts/mkdep acquirewdt.c adbmouse.c amigamouse.c amikeyb.c
atar
imouse.c atixlmouse.c bt848.h bttv.c bttv.h busmouse.c buz.c buz.h
bw-qcam.c bw-
qcam.h c-qcam.c cd1865.h chipsets.h conmakehash.c console.c
console_macros.h con
solemap.c cyclades.c defkeymap.c digi.h digi_bios.h digi_fep.h dn_keyb.c
dsp56k.
c dtlk.c dz.c dz.h epca.c esp.c fep.h generic_serial.c h8.c h8.h i2c.c
ip2.c ip2
main.c isicom.c istallion.c keyboard.c lp.c lp_intern.c lp_m68k.c mac_SCC.c
mac_
SCC.h mem.c misc.c mixcomwd.c moxa.c msbusmouse.c msp3400.c msp3400.h
mxser.c n_
hdlc.c n_tty.c nvram.c pc110pad.c pc110pad.h pc_keyb.c pcwd.c pcxx.c pcxx.h
plan
b.c planb.h pms.c pty.c qpmouse.c radio-aimslab.c radio-aztech.c
radio-cadet.c r
adio-gemtek.c radio-miropcm20.c radio-rtrack2.c radio-sf16fmi.c
radio-trust.c ra
dio-typhoon.c radio-zoltrix.c random.c riscom8.c riscom8.h riscom8_reg.h
rocket.
c rocket_int.h rsf16fmi.h rtc.c saa5249.c saa7111.c saa7185.c saa7196.h
selectio
n.c serial.c serial167.c softdog.c specialix.c specialix_io8.h stallion.c
sx.c s
x.h sxboards.h sxwindow.h synclink.c sysrq.c tpqic02.c tty_io.c tty_ioctl.c
tune
r.c tuner.h vc_screen.c videodev.c vino.c vino.h vt.c wd501p.h wdt.c
zr36057.h z
r36060.h > .depend
make _sfdep_rio _sfdep_ftape _sfdep_joystick _FASTDEP_ALL_SUB_DIRS=" rio
ftape j
oystick"
make[5]: Entering directory
`/mnt/ibm/sin/src/kernel/linux.vger/drivers/char'
make -C rio fastdep
make[6]: Entering directory
`/mnt/ibm/sin/src/kernel/linux.vger/drivers/char/rio
'
make[6]: *** No rule to make target `fastdep'.  Stop.
make[6]: Leaving directory
`/mnt/ibm/sin/src/kernel/linux.vger/drivers/char/rio'
make[5]: *** [_sfdep_rio] Error 2
make[5]: Leaving directory `/mnt/ibm/sin/src/kernel/linux.vger/drivers/char'
make[4]: *** [fastdep] Error 2
make[4]: Leaving directory `/mnt/ibm/sin/src/kernel/linux.vger/drivers/char'
make[3]: *** [_sfdep_char] Error 2
make[3]: Leaving directory `/mnt/ibm/sin/src/kernel/linux.vger/drivers'
make[2]: *** [fastdep] Error 2
make[2]: Leaving directory `/mnt/ibm/sin/src/kernel/linux.vger/drivers'
make[1]: *** [_sfdep_drivers] Error 2
make[1]: Leaving directory `/mnt/ibm/sin/src/kernel/linux.vger'
make: *** [dep-files] Error 2
[root@beer linux]#


--==========150348346==========
Content-Type: text/enriched; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

<fontfamily><param>MS Sans Serif</param><flushleft>This is the output I get =
when doing a make dep:

Is this an error that neds to be fixed in the tree, or is it on my end =
alone?


I think that maybe the text "radio" got replaced with "rio"?



make -C char fastdep

make[4]: Entering directory =
`/mnt/ibm/sin/src/kernel/linux.vger/drivers/char'

/usr/src/linux/scripts/mkdep acquirewdt.c adbmouse.c amigamouse.c amikeyb.c =
atar

imouse.c atixlmouse.c bt848.h bttv.c bttv.h busmouse.c buz.c buz.h =
bw-qcam.c bw-

qcam.h c-qcam.c cd1865.h chipsets.h conmakehash.c console.c =
console_macros.h con

solemap.c cyclades.c defkeymap.c digi.h digi_bios.h digi_fep.h dn_keyb.c =
dsp56k.

c dtlk.c dz.c dz.h epca.c esp.c fep.h generic_serial.c h8.c h8.h i2c.c =
ip2.c ip2

main.c isicom.c istallion.c keyboard.c lp.c lp_intern.c lp_m68k.c mac_SCC.c =
mac_

SCC.h mem.c misc.c mixcomwd.c moxa.c msbusmouse.c msp3400.c msp3400.h =
mxser.c n_

hdlc.c n_tty.c nvram.c pc110pad.c pc110pad.h pc_keyb.c pcwd.c pcxx.c pcxx.h =
plan

b.c planb.h pms.c pty.c qpmouse.c radio-aimslab.c radio-aztech.c =
radio-cadet.c r

adio-gemtek.c radio-miropcm20.c radio-rtrack2.c radio-sf16fmi.c =
radio-trust.c ra

dio-typhoon.c radio-zoltrix.c random.c riscom8.c riscom8.h riscom8_reg.h =
rocket.

c rocket_int.h rsf16fmi.h rtc.c saa5249.c saa7111.c saa7185.c saa7196.h =
selectio

n.c serial.c serial167.c softdog.c specialix.c specialix_io8.h stallion.c =
sx.c s

x.h sxboards.h sxwindow.h synclink.c sysrq.c tpqic02.c tty_io.c tty_ioctl.c =
tune

r.c tuner.h vc_screen.c videodev.c vino.c vino.h vt.c wd501p.h wdt.c =
zr36057.h z

r36060.h > .depend

make _sfdep_rio _sfdep_ftape _sfdep_joystick _FASTDEP_ALL_SUB_DIRS=3D" rio =
ftape j

oystick"

make[5]: Entering directory =
`/mnt/ibm/sin/src/kernel/linux.vger/drivers/char'

make -C rio fastdep

make[6]: Entering directory =
`/mnt/ibm/sin/src/kernel/linux.vger/drivers/char/rio

'

make[6]: *** No rule to make target `fastdep'.  Stop.

make[6]: Leaving directory =
`/mnt/ibm/sin/src/kernel/linux.vger/drivers/char/rio'

make[5]: *** [_sfdep_rio] Error 2

make[5]: Leaving directory =
`/mnt/ibm/sin/src/kernel/linux.vger/drivers/char'

make[4]: *** [fastdep] Error 2

make[4]: Leaving directory =
`/mnt/ibm/sin/src/kernel/linux.vger/drivers/char'

make[3]: *** [_sfdep_char] Error 2

make[3]: Leaving directory `/mnt/ibm/sin/src/kernel/linux.vger/drivers'

make[2]: *** [fastdep] Error 2

make[2]: Leaving directory `/mnt/ibm/sin/src/kernel/linux.vger/drivers'

make[1]: *** [_sfdep_drivers] Error 2

make[1]: Leaving directory `/mnt/ibm/sin/src/kernel/linux.vger'

make: *** [dep-files] Error 2

[root@beer linux]#



--==========150348346==========--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
