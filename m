Subject: Re: [PATCH 2.6] Hydra i2c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>,
	Greg Kroah-Hartman <greg@kroah.com>, sensors@stimpy.netroedge.com,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.58.0401181323130.653@callisto>
References: <Pine.LNX.4.58.0401181323130.653@callisto>
Content-Type: text/plain
Message-Id: <1074468637.814.38.camel@gaston>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 10:30:37 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-01-18 at 23:28, Geert Uytterhoeven wrote:
> The patch below adds support for the i2c interface on the Apple Hydra
> Mac I/O, which is used in the CHRP LongTrail. It was tested using the
> eeprom driver, which detected my 2 SDRAM DIMMs.
>
> The patch is relative to 2.6.0 in the linuxppc-2.5 tree on December 22,
> but it should apply fairly easy to any recent 2.6 tree.

For 2.6, you should really convert Hydra to use the pmac_feature & macio_asic
framework... I'll soon send a patch that will, among others, move mesh support
to macio-style probing only and I'd like the hydra ADB to be moved that way
as well (along with your hydra i2c btw).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
