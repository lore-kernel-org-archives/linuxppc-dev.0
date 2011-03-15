Return-Path: <wim@iguana.be>
Received: from mailrelay004.isp.belgacom.be (mailrelay004.isp.belgacom.be
	[195.238.6.170]) by ozlabs.org (Postfix) with ESMTP id 975F4B6FDE
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 05:19:09 +1100 (EST)
Date: Tue, 15 Mar 2011 19:19:04 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [v2] watchdog: booke_wdt: clean up status messages
Message-ID: <20110315181904.GM1751@infomag.iguana.be>
References: <1297208386-15010-1-git-send-email-timur@freescale.com>
	<C8B1E427-5A9D-4ED2-9C39-C1D8201E636E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C8B1E427-5A9D-4ED2-9C39-C1D8201E636E@kernel.crashing.org>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

I allready had it in the watchdog tree for a couple of weeks (and thus also in linux-next).
Are you going to sent it of to Linus or will I sent it over via the watchdog tree?

Thanks in advance,
Wim.

> 
> On Feb 8, 2011, at 5:39 PM, Timur Tabi wrote:
> 
> > Improve the status messages that are displayed during some operations of the
> > PowerPC watchdog timer driver.  When the watchdog is enabled, the timeout is
> > displayed as a number of seconds, instead of an obscure "period".  The "period"
> > is the position of a bit in a 64-bit timer register.  The higher the value,
> > the quicker the watchdog timeout occurs.  Some people chose a high "period"
> > value for the timer and get confused as to why the board resets within a
> > few seconds.
> > 
> > Messages displayed during open and close are now debug messages, so that they
> > don't clutter the console by default.  Finally, printk() is replaced with the
> > pr_xxx() equivalent.
> > 
> > Signed-off-by: Timur Tabi <timur@freescale.com>
> > ---
> > drivers/watchdog/booke_wdt.c |   19 +++++++++----------
> > 1 files changed, 9 insertions(+), 10 deletions(-)
> 
> applied
> 
> - k
