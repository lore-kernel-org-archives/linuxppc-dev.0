Message-ID: <20040811053400.58837.qmail@web15602.mail.cnb.yahoo.com>
Date: Wed, 11 Aug 2004 13:34:00 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: Boot time with several filesystems on RPXlite DW 
To: Wolfgang Denk <wd@denx.de>, Tom Rini <trini@kernel.crashing.org>
Cc: Song Sam <samlinuxppc@yahoo.com.cn>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040810223917.AC0ABC109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk <wd@denx.de> wrote£º

> > Try trimming down the .config. For example, it doesn't look like you
> > need IP_PNP enabled as you aren't NFSrooting and can just bring the
> > interface up later.
>
> This depends. If the application needs network access, it is usually
> faster to use IP_PNP instead of loading and running ifconfig and
> route. [At least under 2.4; don't know timings for 2.6.]

OK.I tested with no IP_PNP,there was a 2 seconds
decrease on boot time.After setting "verify=no" to
mask CRC32 checksum,the boot time came to 11"78.Then
without IP_PNP,the boot time was 9"69.Close to my
expected 8 seconds.Yeah,there are some special option
in my .config,like framebuffer and USB HOST mode
configuration.

I tried to optimize minimum access times for SDRAM in
U-Boot,almost no obvious improvement.I need time to
optimize SDRAM and FLASH access times.I took
Wolfgang's example to use uncompressed kernel and
ramdisk.

Thanks a lot for your help.

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
