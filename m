Date: Thu, 10 Aug 2000 12:49:41 -0500
Message-Id: <200008101749.e7AHnfM28487@lists.msoe.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: X4 Rage 128 Driver Error:
From: ian reinhart geiser <geiseri@msoe.edu>
Reply-To: geiseri@msoe.edu
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings,
	I am having problems building rage drivers for X4.0.1 on my
	imac DV.

	I always seem to get to following error:
rm -f r128_driver.o
gcc -c -O2 -fsigned-char   -I.
-I../../../../../../programs/Xserver/hw/xfree86/common
-I../../../../../../programs/Xserver/hw/xfree86/os-support
-I../../../../../../programs/Xserver/mfb
-I../../../../../../programs/Xserver/mi
-I../../../../../../programs/Xserver/hw/xfree86/xaa
-I../../../../../../programs/Xserver/hw/xfree86/rac
-I../../../../../../programs/Xserver/fb
-I../../../../../../programs/Xserver/cfb
-I../../../../../../programs/Xserver/hw/xfree86/xaa
-I../../../../../../programs/Xserver/hw/xfree86/ramdac
-I../../../../../../programs/Xserver/hw/xfree86/vgahw
-I../../../../../../programs/Xserver/hw/xfree86/fbdevhw
-I../../../../../../programs/Xserver/hw/xfree86/ddc
-I../../../../../../programs/Xserver/hw/xfree86/i2c
-I../../../../../../programs/Xserver/hw/xfree86/os-support/vbe
-I../../../../../../programs/Xserver/hw/xfree86/int10
-I../../../../../../programs/Xserver/Xext
-I../../../../../../include/fonts -I../../../../../../programs/Xserver/include
-I../../../../../../exports/include/X11
-I../../../../../../include/extensions
-I../../../../../../programs/Xserver/hw/xfree86/xf24_32bpp
-I../../../../../.. -I../../../../../../exports/include  -Dlinux -D__powerpc__
-D_POSIX_C_SOURCE=199309L -D_POSIX_SOURCE -D_XOPEN_SOURCE -D_BSD_SOURCE
-D_SVID_SOURCE  -D_GNU_SOURCE  -DSHAPE -DXINPUT -DXKB -DLBX -DXAPPGROUP
-DXCSECURITY -DTOGCUP  -DXF86BIGFONT -DDPMSExtension  -DPIXPRIV -DPANORAMIX
-DGCCUSESGAS -DAVOID_GLYPHBLT -DPIXPRIV -DSINGLEDEPTH -DXFreeXDGA
-DXvExtension -DXFree86LOADER  -DXFree86Server -DXF86VIDMODE  -DSMART_SCHEDULE
-DX_BYTE_ORDER=X_BIG_ENDIAN -DNDEBUG   -DFUNCPROTO=15 -DNARROWPROTO
-DIN_MODULE   r128_driver.c
r128_driver.c: In function `R128RestoreMode':
r128_driver.c:2108: `CONFIG_CNTL' undeclared (first use in this function)
r128_driver.c:2108: (Each undeclared identifier is reported only once
r128_driver.c:2108: for each function it appears in.)
make: *** [r128_driver.o] Error 1

I am using the latest rsync from LinuxPPC.org so i figured it would work.
Can anyone point me in a better direction?

Thanks

	-ian reinhart geiser

--
This message was sent from the MSOE Web Mail interface at
http://mail.msoe.edu/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
