Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-8.online-age.net (Ext-cn0ut-8.online-age.net
	[63.210.253.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9D2DADDDE0
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 17:56:11 +1000 (EST)
Received: from int-cn0ut-5.online-age.net (int-cn0ut-5.online-age.net
	[3.159.252.74])
	by ext-cn0ut-8.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m917tvAN005778
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 03:55:57 -0400
Received: from alpmlip01.e2k.ad.ge.com (int-cn0ut-5.online-age.net
	[3.159.252.74])
	by int-cn0ut-5.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m917u77L017108
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 03:56:07 -0400
Date: Wed, 1 Oct 2008 08:57:23 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2] powerpc: GE Fanuc's FPGA based PIC controller on the
	SBC610
Message-Id: <20081001085723.da48e53a.martyn.welch@gefanuc.com>
In-Reply-To: <20081001011753.GA30810@yookeroo.seuss>
References: <20080930153058.29602.28885.stgit@ubuntu8041.localdomain>
	<20081001011753.GA30810@yookeroo.seuss>
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

On Wed, 1 Oct 2008 11:17:53 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:
> On Tue, Sep 30, 2008 at 04:34:56PM +0100, Martyn Welch wrote:
> > +		gef_pic: pic@4,4000 {
> > +			#interrupt-cells = <2>;
> > +			interrupt-controller;
> > +			device_type = "interrupt-controller";
> 
> I don't think you should need this device_type.
> 

Ok.

Thanks,

Martyn


-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
