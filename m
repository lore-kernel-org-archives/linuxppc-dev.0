Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5B0BADDDE0
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 07:28:43 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Fix Book-E watchdog timer interval setting
Date: Fri, 19 Sep 2008 23:28:35 +0200
References: <200808071448.06183.matthias.fuchs@esd-electronics.com>
	<A4CCB071-0FCE-490A-B563-399FCA74C71E@kernel.crashing.org>
In-Reply-To: <A4CCB071-0FCE-490A-B563-399FCA74C71E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809192328.36159.matthias.fuchs@esd-electronics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

should I resend this my patch? Is there chance to get it applied.
It really fixes a bug!

Matthias

On Thursday 07 August 2008 15:19:10 Kumar Gala wrote:
> On Aug 7, 2008, at 7:48 AM, Matthias Fuchs wrote:
> > This patch fixes the setting of the Book-E watchdog timer interval
> > setup
> > on initialization and by ioctl().
> >
> > Tested on PPC440EPx sequoia evaluation board.
> >
> > Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
> > ---
> > drivers/watchdog/booke_wdt.c |    6 +++++-
> > 1 files changed, 5 insertions(+), 1 deletions(-)
>
> can you be more explicit about what the bug was.
>
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
