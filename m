Message-ID: <39CF2C54.75A03C09@wtal.de>
Date: Mon, 25 Sep 2000 12:43:32 +0200
From: Christof Petig <christof.petig@wtal.de>
MIME-Version: 1.0
To: Carl Potter <carl@PsychiatryKills.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: new iBook and booting.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Carl,

>This is the point where the screen freezes, leaving the above message
>perfectly readable, yet the kernel continues to boot normally and
mounts
>the drive.  I then have to blind-type my username, password, and issue
a
>"shutdown -r now".

>Any light you might shed on this would be very appreciated.  I think
>Linux on PPC is great stuff and I thank you for making possible what we

>can already do with it.

Please try to build a kernel with CONFIG_FBCON_FONTWIDTH8_ONLY enabled.
This fixed the problem for me (300Mhz,6GB iBook).

Though, admittedly, I don't see any reason in this.

Christof

PS: 433Mhz - I should have waited buying one ...

PPS: if I guessed wrong, here's the relevant part of my .config:
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_ATY=y
CONFIG_FB_OF=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTWIDTH8_ONLY=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_SUN8x16=y
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
