Subject: Re: 2.6.0-test2-bk2 (linus' tree) --
	arch/ppc/platforms/pmac_cpufreq.c:219: undefined reference to
	`cpufreq_frequency_table_verify'
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Larry McVoy <lm@bitmover.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030804152619.GA30195@work.bitmover.com>
References: <200308031456.11550.miles.lane@comcast.net>
	 <1059948097.602.1.camel@gaston>
	 <16174.17597.565364.862198@cargo.ozlabs.ibm.com>
	 <20030804152619.GA30195@work.bitmover.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1060011549.900.50.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: 04 Aug 2003 17:39:09 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-08-04 at 17:26, Larry McVoy wrote:
> > Here is what I have in a tree locally to go to Linus.  I can't push it
> > out because ppc.bkbits.net seems to be down.
>
> It's back.  If anyone has any insight into how to track down kernel hangs
> I'd love to hear them.  bkbits.net has been flakey in the last couple of
> months and sometimes just hangs, last night's was with pings still working
> but no response at the console.

Which kernel is it running? Something like this happened to every 2.4.21
kernel I've tried soon after they hit swap. I thought it might be a bad
interaction of the 2.4.21 VM, CONFIG_HIGHMEM and the XFS and whatnot
patches and went back to good old 2.4.20-ben8.


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
