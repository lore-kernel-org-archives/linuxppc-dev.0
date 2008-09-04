Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-1.online-age.net (ext-cn0ut-1.online-age.net
	[63.210.253.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A6D50DDF83
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 18:18:00 +1000 (EST)
Received: from int-cn0ut-2.online-age.net (int-cn0ut-2.online-age.net
	[3.159.252.71])
	by ext-cn0ut-1.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m848Hu7d001291
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 04:17:57 -0400
Received: from cinmlip01.e2k.ad.ge.com (int-cn0ut-2.online-age.net
	[3.159.252.71])
	by int-cn0ut-2.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m848HuPo020978
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 04:17:56 -0400
Date: Thu, 4 Sep 2008 09:17:42 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v4 1/2] powerpc: Board support for GE Fanuc SBC610
Message-Id: <20080904091742.52104869.martyn.welch@gefanuc.com>
In-Reply-To: <20080902182709.GB16741@ld0162-tx32.am.freescale.net>
References: <20080901102753.8068.36706.stgit@ubuntu8041.localdomain>
	<20080901102758.8068.77414.stgit@ubuntu8041.localdomain>
	<20080902182709.GB16741@ld0162-tx32.am.freescale.net>
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

On Tue, 2 Sep 2008 13:27:09 -0500
Scott Wood <scottwood@freescale.com> wrote:

> On Mon, Sep 01, 2008 at 11:27:59AM +0100, Martyn Welch wrote:
> > +static __initdata struct of_device_id of_bus_ids[] = {
> > +	{ .compatible = "simple-bus", },
> > +	{ .type = "serial", },
> > +	{ .type = "soc", },
> > +	{ .type = "i2c", },
> 
> i2c and serial don't belong here, and soc is redundant with simple-bus.
> 

Hmm, I had to put those in to get the relevant parts to work - somethings obviously changed. I'll remove them and see what happens. 

Thanks again for the feedback,

Martyn

> -Scott


-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
