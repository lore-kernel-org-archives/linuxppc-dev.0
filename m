Subject: Re: new ATI sleep code freezes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mutex@kerneli.org
Cc: Michel D?nzer <michel@daenzer.net>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030605163550.GL1982@heliosphan>
References: <20030529154143.GC7896@heliosphan>
	 <1054496170.25677.28.camel@thor.holligenstrasse29.lan>
	 <20030604162837.GF1982@heliosphan> <1054746955.696.7.camel@gaston>
	 <20030605163550.GL1982@heliosphan>
Content-Type: text/plain
Message-Id: <1054831673.813.37.camel@gaston>
Mime-Version: 1.0
Date: 05 Jun 2003 18:47:53 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-06-05 at 18:35, mutex@kerneli.org wrote:
> On Wed, Jun 04, 2003 at 07:15:55PM +0200 or thereabouts, Benjamin Herrenschmidt wrote:
> > Also make sure you have APM emulation working (check XFree log to see if it found & opened the APM device)
>
> from my XF86Config file...
>
> (WW) Open APM failed (/dev/apm_bios) (No such file or directory)
>
> But my kernel config says...
> CONFIG_PMAC_APM_EMU=y
>
> The only thing unusual is I am running devfs..

Poor boy... ;)

> so i checked /dev
>
> heliosphan dev # find . -name *apm*
> ./misc/apm_bios
> ./apm_bios
>
> /dev/misc/apm_bios has perms:
>
> crw-------    1 mutex    root      10, 134 Dec 31  1969 apm_bios
>
> are those normal permissions ?  Also, I'm running an enlightenment battery applet which afaik uses apm layer to report battery level.  So something has to be working.
> Dave

I don't know wtf with devfs & perms, but the problem is here, once you
fix that, it should work much better ;)

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
