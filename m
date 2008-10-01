Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-4.online-age.net (ext-cn0ut-4.online-age.net
	[63.210.253.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id ED204DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 17:55:17 +1000 (EST)
Received: from int-cn0ut-2.online-age.net (int-cn0ut-2.online-age.net
	[3.159.252.71])
	by ext-cn0ut-4.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m917tEWV009901
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 03:55:14 -0400
Received: from cinmlip01.e2k.ad.ge.com (int-cn0ut-2.online-age.net
	[3.159.252.71])
	by int-cn0ut-2.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m917tEmn023449
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 03:55:14 -0400
Date: Wed, 1 Oct 2008 08:56:30 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: GE Fanuc's FPGA based PIC controller on the
	SBC610
Message-Id: <20081001085630.649e85a0.martyn.welch@gefanuc.com>
In-Reply-To: <20080930170847.GA25725@ld0162-tx32.am.freescale.net>
References: <20080930142942.28193.943.stgit@ubuntu8041.localdomain>
	<20080930170847.GA25725@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 30 Sep 2008 12:08:47 -0500
Scott Wood <scottwood@freescale.com> wrote:
> On Tue, Sep 30, 2008 at 03:29:42PM +0100, Martyn Welch wrote:
> > +		gef_pic: pic@4,4000 {
> > +			#interrupt-cells = <2>;
> 
> What is the second interrupt cell for, given that all interrupts are
> level-triggered and you don't implement .set_type?
> 

An error I guess. Queue v3 ;-)

Thanks,

Martyn

> -Scott


-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
