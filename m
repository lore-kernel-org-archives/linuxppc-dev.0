Message-ID: <3F6027E2.C59D7ACC@gdatech.co.in>
Date: Thu, 11 Sep 2003 13:14:34 +0530
From: Rakesh Jagota <j.rakesh@gdatech.co.in>
MIME-Version: 1.0
To: PPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: PPC 405
References: <5.2.1.1.2.20030910174452.02767580@192.168.1.10> <3F5FEFA0.1080809@embeddededge.com> <3F6021CD.CC35DC55@gdatech.co.in>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,

i am trying to integrate IR keyboard to a custom board.
I am having serial console on the boad.

when i am calling handle_scancode in keyboard.c
this statement,

 void handle_scancode(unsigned char scancode, int down)
 {
 -----
 tty = ttytab? ttytab[fg_console]: NULL;
 ;
 }

returns tty=NULL

          __init kbd_init(void)
 {
  ------
  ------
  ttytab = console_driver.table;
 }

in this fuction also ttytab[fg_console] is still NULL

Is serial console is enough to keyboard?

i have frambuffer support on my board. (without HW
      graphic accelerator)

How to enable the frambufffer console on my board.
      (i am attaching the config file below)

===========#
#
CONFIG_PC_KEYBOARD=y
#
# Console drivers
#

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_OF is not set
# CONFIG_FB_CONTROL is not set
# CONFIG_FB_PLATINUM is not set
# CONFIG_FB_VALKYRIE is not set
# CONFIG_FB_CT65550 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_S3TRIO is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_MQ200 is not set
# CONFIG_FB_IT8181 is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FBCON_ADVANCED=y
# CONFIG_FBCON_MFB is not set
# CONFIG_FBCON_CFB2 is not set
# CONFIG_FBCON_CFB4 is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
# CONFIG_FBCON_CFB24 is not set
# CONFIG_FBCON_CFB32 is not set
# CONFIG_FBCON_AFB is not set
# CONFIG_FBCON_ILBM is not set
# CONFIG_FBCON_IPLAN2P2 is not set
# CONFIG_FBCON_IPLAN2P4 is not set
# CONFIG_FBCON_IPLAN2P8 is not set
# CONFIG_FBCON_MAC is not set
# CONFIG_FBCON_VGA_PLANES is not set
# CONFIG_FBCON_VGA is not set
# CONFIG_FBCON_HGA is not set
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
CONFIG_FONT_ACORN_8x8=y

#
# Input core support
#
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Macintosh device drivers
#

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

##
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set
# CONFIG_RWMOUSE is not set

========================================================

Ur suggestions are appreciated
Thanks in advance
Rakesh Jagota

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
