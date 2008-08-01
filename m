Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D9309DDF75
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 08:26:32 +1000 (EST)
Subject: Re: ide pmac breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200808011254.02989.bzolnier@gmail.com>
References: <1217208596.11188.144.camel@pasglop>
	<1217478322.11188.410.camel@pasglop>
	<200807311251.02251.bzolnier@gmail.com>
	<200808011254.02989.bzolnier@gmail.com>
Content-Type: text/plain
Date: Sat, 02 Aug 2008 08:26:18 +1000
Message-Id: <1217629578.11188.516.camel@pasglop>
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

On Fri, 2008-08-01 at 12:54 +0200, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 31 July 2008, Bartlomiej Zolnierkiewicz wrote:
> 
> [...]
> 
> Sorry if my mails were a bit harsh but nobody likes to be pushed around.
> 
> [ It is not like I don't want to add proper hot-plugging support or do test
>   on more hardware but my time schedule is already tight enough and there are
>   still more fundamental things to address (which take priority). ]
> 
> > -                host->dev[0] = hws[0]->dev;
> > +                host->dev[0] = hws[0]->parent ? hws[0]->parent : hws[0]->dev;
> > 
> > Could you please try it together with my previous patch for
> > ide_device_{get,put}()?
> 
> Please test it when you have some time.

The problem in that case is access to the HW :-) I have plenty ide-pmac
based machines but only one or two old laptop (ie. Paul has one too)
with a media-bay and those are in the office. So I'll test on Monday
when I get there, unless I get a chance to pop by on Sunday but that's
unlikely.

Ben.
