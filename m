Return-Path: <a.gusev1980@mail.ru>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4CCB3B7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 05:27:26 +1000 (EST)
Received: from mx75.mail.ru (mx75.mail.ru [94.100.176.90])
	by ozlabs.org (Postfix) with ESMTP id D4B8CDDDE5
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 05:27:25 +1000 (EST)
Date: Mon, 13 Jul 2009 23:27:21 +0400
From: Andrey Gusev <a.gusev1980@mail.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Delay on intialization ide subsystem(most likely)
Message-ID: <20090713232721.04e3a80b@power-debian>
In-Reply-To: <1247015562.6066.59.camel@pasglop>
References: <20090425170203.74603b9c@power-debian>
	<200906101344.30057.bzolnier@gmail.com>
	<20090705151754.6034ffad@power-debian>
	<200907061704.38539.bzolnier@gmail.com>
	<1246922623.22625.57.camel@pasglop>
	<20090708011802.74a7c21b@power-debian>
	<1247015562.6066.59.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com,
	David Miller <davem@davemloft.net>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 08 Jul 2009 11:12:42 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2009-07-08 at 01:18 +0400, Andrey Gusev wrote:
> 
> > I tried this drive on ide1 and ide2, there are same issue. This
> > drive worked on P-III before (as separate on channel, with another
> > hard drive and with cdrom) and I didn't have any problem with it.
> > There are chunks of dmesg.
> 
> Wow... It also fails with MWDMA2 ! That's just plain weird. It fails
> as master as well as slave too. Hrm. I wonder if it could be your
> cable... Do you have other machines (non-powermac) you can try that
> drive again just in case it toast itself in some way too ?

It couldn't be cable, because all tests were on different cables. Unfortunately,
I don't have another machine. I try find one, but it wouldn't be fast. This drive
used early and I didn't have any problems. It was unused some time and may be something 
happened with it.
Note, it was slave only with another hard disk, in other cases it was master (single on
cable). 

> 
> Bart, I don't suppose we know of any problem with those drive models ?
> (Q. FireballP LM20.5)
> 
> Cheers,
> Ben.
> 
> 
