Message-ID: <4926614F7A31D411820F00D0B74FF7E0013D1A1D@RDC03>
From: "Gallant, John" <jgallant@vanteon.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Assistance with using /dev/fb0 and No X windows
Date: Mon, 13 Jan 2003 11:23:04 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

    I have managed to get the "default" VGA/FB support to access my graphics
device on the onboard PCI bus.  We a SMI LynxEM chip on the board.  I have
the vga init() code properly accessing the device and the on chip frame
buffer.  I have used fbset to determine if /dev/fb0 can be accessed, and the
driver is called.  I also tried "ls -l > /dev/fb0" this also gets into the
vga16fb_get_fix() code.

    What I need to do, and here is my lack of understanding, is to have some
program access the /dev/fb0 device and display on the CRT.  I do not have
any X support, only whatever came with the MVL distribution.  I am wondering
what is necessary to use mingetty, or some other display method.

    Added wrinkles:  No keyboard yet, but I do have the console=ttyS0
working.

    So any advice on what I could use or what I may have missed in my
Xconfig settings?

The following is what I have for the CONFIG_FB settings:
#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_CT65550 is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=y
# CONFIG_FB_MQ200 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_IT8181 is not set
CONFIG_FB_VIRTUAL=y
CONFIG_FBCON_ADVANCED=y
# CONFIG_FBCON_MFB is not set
# CONFIG_FBCON_CFB2 is not set
# CONFIG_FBCON_CFB4 is not set
# CONFIG_FBCON_CFB8 is not set
# CONFIG_FBCON_CFB16 is not set
# CONFIG_FBCON_CFB24 is not set
# CONFIG_FBCON_CFB32 is not set
# CONFIG_FBCON_AFB is not set
# CONFIG_FBCON_ILBM is not set
# CONFIG_FBCON_IPLAN2P2 is not set
# CONFIG_FBCON_IPLAN2P4 is not set
# CONFIG_FBCON_IPLAN2P8 is not set
# CONFIG_FBCON_MAC is not set
CONFIG_FBCON_VGA_PLANES=y
CONFIG_FBCON_VGA=y
# CONFIG_FBCON_HGA is not set
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

Thank you

--------------------------------------------
John A. Gallant
Sr. Embedded Software Engineer
Vanteon Inc.
2851 Clover Street
Pittsford, NY 14534
Phone: 585.248.0510 x279
Fax  : 585.248.0537
email: jgallant@vanteon.com
web: www.vanteon.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
