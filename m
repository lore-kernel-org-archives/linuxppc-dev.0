From: mutex@kerneli.org
Date: Thu, 5 Jun 2003 09:35:50 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michel D?nzer <michel@daenzer.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: new ATI sleep code freezes
Message-ID: <20030605163550.GL1982@heliosphan>
References: <20030529154143.GC7896@heliosphan> <1054496170.25677.28.camel@thor.holligenstrasse29.lan> <20030604162837.GF1982@heliosphan> <1054746955.696.7.camel@gaston>
Mime-Version: 1.0
In-Reply-To: <1054746955.696.7.camel@gaston>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jun 04, 2003 at 07:15:55PM +0200 or thereabouts,
Benjamin Herrenschmidt wrote:
> Also make sure you have APM emulation working (check XFree log to see
> if it found & opened the APM device)

from my XF86Config file...

(WW) Open APM failed (/dev/apm_bios) (No such file or directory)

But my kernel config says...
CONFIG_PMAC_APM_EMU=y

The only thing unusual is I am running devfs..
so i checked /dev

heliosphan dev # find . -name *apm*
./misc/apm_bios
./apm_bios

/dev/misc/apm_bios has perms:

crw-------    1 mutex    root      10, 134 Dec 31  1969 apm_bios

are those normal permissions ? Also, I'm running an enlightenment
battery applet which afaik uses apm layer to report battery level. So
something has to be working.

Dave

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
