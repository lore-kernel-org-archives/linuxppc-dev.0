Message-ID: <20040725030003.5401.qmail@web15204.mail.bjs.yahoo.com>
Date: Sun, 25 Jul 2004 11:00:03 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Could 2_4_devel support RPXlite DW LCD panel? 
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040723172210.5B396C109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I want to port 2_4_devel on RPXlite DW with
framebuffer support and tried linuxppc_2_4_devel in
linuxppc official BK tree and DENX tree repectively
but failed.Could anyone try it before?Worked?

----[The config part of frame buffer support]----
...
CONFIG_RPXLITE=y
...
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
...
CONFIG_FB_8xx_LCD=y
...
CONFIG_FB_RPX_LCD_NEC=y   ---[Linuxppc BK tree]
CONFIG_NEC_NL6448AC33=y   ---[DENX CVS tree]
...
CONFIG_FBCON_ADVANCED=y
...
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
...
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
...
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
...

-----------------------------------------------

Anyinput would be appreciated!

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
