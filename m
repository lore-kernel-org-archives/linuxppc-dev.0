Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CE690B708E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 11:15:50 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59272DDEE0
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 11:15:48 +1000 (EST)
Subject: Re: Delay on intialization ide subsystem(most likely)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrey Gusev <a.gusev1980@mail.ru>
In-Reply-To: <20090708011802.74a7c21b@power-debian>
References: <20090425170203.74603b9c@power-debian>
	<200906101344.30057.bzolnier@gmail.com>
	<20090705151754.6034ffad@power-debian>
	<200907061704.38539.bzolnier@gmail.com>
	<1246922623.22625.57.camel@pasglop>
	<20090708011802.74a7c21b@power-debian>
Content-Type: text/plain
Date: Wed, 08 Jul 2009 11:12:42 +1000
Message-Id: <1247015562.6066.59.camel@pasglop>
Mime-Version: 1.0
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

On Wed, 2009-07-08 at 01:18 +0400, Andrey Gusev wrote:

> I tried this drive on ide1 and ide2, there are same issue. This drive worked
> on P-III before (as separate on channel, with another hard drive and with cdrom)
> and I didn't have any problem with it. There are chunks of dmesg.

Wow... It also fails with MWDMA2 ! That's just plain weird. It fails as
master as well as slave too. Hrm. I wonder if it could be your cable...
Do you have other machines (non-powermac) you can try that drive again
just in case it toast itself in some way too ?

Bart, I don't suppose we know of any problem with those drive models ?
(Q. FireballP LM20.5)

Cheers,
Ben.
