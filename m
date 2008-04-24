Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9E10DE2A6
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 01:50:43 +1000 (EST)
Date: Thu, 24 Apr 2008 17:53:03 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: mpc5200b custom board upstreamable?
Message-ID: <20080424155303.GK6692@pengutronix.de>
References: <20080424151237.GI6692@pengutronix.de>
	<fa686aa40804240813p66889769y3bee6eb0111741f7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40804240813p66889769y3bee6eb0111741f7@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 24, 2008 at 09:13:45AM -0600, Grant Likely wrote:
> On Thu, Apr 24, 2008 at 9:12 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >
> >  Hi all,
> >
> >  I had the intention to push the code for a custom mpc5200b board (freely
> >  available, no internal project) upstream. After cleaning up the code I
> >  realized that actually no board specific code is left and our board is
> >  well handled by the mpc5200_simple_platform machine.
> >
> >  The only issue is that the machine only matches things like
> >  "schindler,cm5200", there's no generic entry. Would it be possible to
> >  add a "generic-mpc52xx" entry to this list?
> 
> I'm being cautious about this for the time being.  I'd like to have a
> generic match mechanism, but I don't want to do something that isn't
> easy to recover from if it turns out to be brain dead.  For now, just
> add your board name to the explicit match list.

The board is called "generic". No, just kidding ;)

> 
> >
> >  Another question: are defconfig and dts files for custom boards acceptable
> >  for upstream?
> 
> Yes, in the arch/powerpc/configs/52xx/ directory.

ok

Sascha

-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-
