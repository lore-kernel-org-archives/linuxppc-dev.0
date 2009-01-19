Return-Path: <bzolnier@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.187])
	by ozlabs.org (Postfix) with ESMTP id 77A54DDE9E
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 05:34:27 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so2139229mue.9
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 10:34:24 -0800 (PST)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
	boards
Date: Mon, 19 Jan 2009 19:28:35 +0100
References: <20090112233909.221080@gmx.net> <1231822958.22571.38.camel@pasglop>
	<20090113123337.199060@gmx.net>
In-Reply-To: <20090113123337.199060@gmx.net>
MIME-Version: 1.0
Message-Id: <200901191928.35474.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 13 January 2009, Gerhard Pircher wrote:
> 
> -------- Original-Nachricht --------
> > Datum: Tue, 13 Jan 2009 16:02:38 +1100
> > Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > An: Gerhard Pircher <gerhard_pircher@gmx.net>
> > CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
> > Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards
> 
> > > Yes, it can wait.
> > > Although I would like to know from the powerpc maintainer, if my
> > > platform patches could still go in 2.6.29, if I resend them in the next days? I
> > > guess it's too late, right?
> > 
> > Yes it is. I'll put them in -next after -rc2 or later, when we are happy
> > with them. That gives us a bit of time to do extra polishing.
> Good, then I'll send out a new patch for the IDE driver and the current one
> can be reverted.

The following patchset fixes core IDE PCI code to always use
pci_get_legacy_ide_irq() and ide_pci_is_in_compatibility_mode():

http://lkml.org/lkml/2009/1/19/163

so via82cxxx specific solution is no longer necessary.

[ IOW I'll keep your previous patch and the #ifdef issue will
  solve itself after the above patchset is merged. ]

Thanks,
Bart
