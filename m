Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id BBABADDED2
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 05:10:11 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
Date: Thu, 15 Feb 2007 19:09:25 +0100
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<200702151141.49708.jens@de.ibm.com>
	<20070215171414.GU923@austin.ibm.com>
In-Reply-To: <20070215171414.GU923@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702151909.26082.arnd@arndb.de>
Cc: Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org, paulus@samba.org,
	Andrew Morton <akpm@linux-foundation.org>,
	James K Lewis <jim@jklewis.com>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 February 2007 18:14, Linas Vepstas wrote:
> > Linas has done a pretty good job on improving the driver in the last half
> > year or so and he also has access to all the necessary hardware so I think
> > he would be the right person for the job.
> 
> It seems I've been nominated twice. Since I'm expecting future activity
> to drop to zero, how hard can this be? :-)

I fear that the hardest part is yet to come, when we integrate the
driver for the the PS3 (currently called gelic_net) into spidernet.
The trouble is that the hardware is sufficiently similar to share
all the high-level mechanisms like the DMA data structures and
descriptor chains, but the low-level mechanisms are hidden in the
hypervisor on the PS3. Someone will have to invest a significant
amount of time coordinating this so we don't break celleb and qs20
in the process.

I also think that you'd do a good job doing this, but it may be
more that what you are willing to do without official funding of the
time you spend on it. Of course the actual amount of work will
depend a lot on the quality of the spidernet patches coming from
Sony to the spidernet maintainer.

	Arnd <><
