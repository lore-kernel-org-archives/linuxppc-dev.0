Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44165DE10E
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 08:49:28 +1000 (EST)
Subject: Re: ide pmac breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200807302111.54514.bzolnier@gmail.com>
References: <1217208596.11188.144.camel@pasglop>
	<200807292126.12238.bzolnier@gmail.com>
	<1217401052.11188.318.camel@pasglop>
	<200807302111.54514.bzolnier@gmail.com>
Content-Type: text/plain
Date: Thu, 31 Jul 2008 08:49:12 +1000
Message-Id: <1217458152.11188.355.camel@pasglop>
Mime-Version: 1.0
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org,
	petkovbb@gmail.com, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-30 at 21:11 +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > Note that there shouldn't be anything fundamentally different from
> > ide-pmac here vs. something like pcmcia IDE cards... do you have one
> of
> > these to test with ?
> 
> Nope and I really don't intend to have one.  I count on other people
> to take some care of support for host drivers that they
> maintain/use. ;)

Hrm... that's not a very sane approach. You have some infrastructure for
adding / removing devices, in fact changes things in that area even, and
not a single piece of HW to exercise those code path ? I don't ask you
to get a powermac with a media-bay, but ide_cs seems to be a pretty
important one that's part of what the ide maintainer should take care
of... And I suspect it's going to exercise the same code path as
mediabay.

Ben.
