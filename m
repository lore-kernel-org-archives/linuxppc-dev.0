Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-4.online-age.net (ext-cn0ut-4.online-age.net
	[63.210.253.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4C1414762A
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 01:35:06 +1000 (EST)
Received: from int-cn0ut-7.online-age.net (int-cn0ut-7.online-age.net
	[3.159.252.76])
	by ext-cn0ut-4.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m84FZ3jp027267
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 11:35:03 -0400
Received: from alpmlip01.e2k.ad.ge.com (int-cn0ut-7.online-age.net
	[3.159.252.76])
	by int-cn0ut-7.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m84FZ3Z0005701
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 11:35:03 -0400
Date: Thu, 4 Sep 2008 16:34:20 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v4 1/2] powerpc: Board support for GE Fanuc SBC610
Message-Id: <20080904163420.fa63088b.martyn.welch@gefanuc.com>
In-Reply-To: <48BFF8E4.9070400@freescale.com>
References: <20080901102753.8068.36706.stgit@ubuntu8041.localdomain>
	<20080901102758.8068.77414.stgit@ubuntu8041.localdomain>
	<20080902182709.GB16741@ld0162-tx32.am.freescale.net>
	<20080904155127.5ca8fca3.martyn.welch@gefanuc.com>
	<48BFF8E4.9070400@freescale.com>
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

On Thu, 04 Sep 2008 10:04:04 -0500
Scott Wood <scottwood@freescale.com> wrote:

> Martyn Welch wrote:
> > On Tue, 2 Sep 2008 13:27:09 -0500
> > Scott Wood <scottwood@freescale.com> wrote:
> > 
> >> On Mon, Sep 01, 2008 at 11:27:59AM +0100, Martyn Welch wrote:
> >>> +static __initdata struct of_device_id of_bus_ids[] = {
> >>> +	{ .compatible = "simple-bus", },
> >>> +	{ .type = "serial", },
> >>> +	{ .type = "soc", },
> >>> +	{ .type = "i2c", },
> >> i2c and serial don't belong here, and soc is redundant with simple-bus.
> >>
> > 
> > I agree about the i2c and serial, although I need the soc entry for the i2c devices to be found during the platform scan.
> 
> Not if the soc node has simple-bus in its compatible, which I thought I 
> remembered yours did.
> 

Um, it will have in the next revision of the patch set ;-)

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
