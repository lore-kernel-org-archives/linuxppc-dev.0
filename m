Subject: Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org>
	 <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be>
Content-Type: text/plain
Message-Id: <1076275377.885.88.camel@gaston>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 08:26:38 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-02-09 at 01:25, Geert Uytterhoeven wrote:
> +config ADB
> +	bool "Apple Desktop Bus (ADB) support"
> +	depends on MAC || PPC_PMAC
> +	help
> +	  Apple Desktop Bus (ADB) support is for support of devices which
> +	  are connected to an ADB port.  ADB devices tend to have 4 pins.
> +	  If you have an Apple Macintosh prior to the iMac, an iBook or
> +	  PowerBook, or a "Blue and White G3", you probably want to say Y
> +	  here.  Otherwise say N.

I'd be more precise, like: ADB devices are usually input devices (mice
and keyboards) connected via a 4 pin daisy chained bus. All Apple
laptops also use ADB internally for the built-in keyboar & trackpad.

Now, for Cuda and PMU, as long as you let them be selected even
without CONFIG_ADB, it's fine.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
