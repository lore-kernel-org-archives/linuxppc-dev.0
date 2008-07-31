Return-Path: <bzolnier@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.189])
	by ozlabs.org (Postfix) with ESMTP id 3E1A4DDEF8
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 10:50:56 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so275228fke.9
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 17:50:54 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: ide pmac breakage
Date: Thu, 31 Jul 2008 02:48:28 +0200
References: <1217208596.11188.144.camel@pasglop>
	<200807302111.54514.bzolnier@gmail.com>
	<1217458152.11188.355.camel@pasglop>
In-Reply-To: <1217458152.11188.355.camel@pasglop>
MIME-Version: 1.0
Message-Id: <200807310248.29214.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="utf-8"
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org,
	petkovbb@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 31 July 2008, Benjamin Herrenschmidt wrote:
> On Wed, 2008-07-30 at 21:11 +0200, Bartlomiej Zolnierkiewicz wrote:
> > 
> > > Note that there shouldn't be anything fundamentally different from
> > > ide-pmac here vs. something like pcmcia IDE cards... do you have one
> > of
> > > these to test with ?
> > 
> > Nope and I really don't intend to have one.  I count on other people
> > to take some care of support for host drivers that they
> > maintain/use. ;)
> 
> Hrm... that's not a very sane approach. You have some infrastructure for
> adding / removing devices, in fact changes things in that area even, and

There seems to be some confusion between warm-plugging of IDE devices
and hot-plugging of IDE devices.

> not a single piece of HW to exercise those code path ? I don't ask you
> to get a powermac with a media-bay, but ide_cs seems to be a pretty
> important one that's part of what the ide maintainer should take care
> of... And I suspect it's going to exercise the same code path as
> mediabay.

I'm open for offers of co-maintaince of the code (which includes taking
over particular host drivers) and since you seem to have pretty good
insight into what ide maintainer should be doing I presume that you want
to be added to MAINTAINERS?
