Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-4.online-age.net (ext-cn0ut-4.online-age.net
	[63.210.253.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 51899DE703
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 22:33:36 +1000 (EST)
Received: from int-cn0ut-3.online-age.net (int-cn0ut-3.online-age.net
	[3.159.252.72])
	by ext-cn0ut-4.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m7QCXVYa030084
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 08:33:31 -0400
Received: from cinmlip01.e2k.ad.ge.com (int-cn0ut-3.online-age.net
	[3.159.252.72])
	by int-cn0ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m7QCXVHH010705
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 08:33:31 -0400
Date: Tue, 26 Aug 2008 13:33:28 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc: Board support for GE Fanuc SBC610
Message-Id: <20080826133328.5458c581.martyn.welch@gefanuc.com>
In-Reply-To: <20080822171135.GA15623@ld0162-tx32.am.freescale.net>
References: <20080822104615.11984.93838.stgit@ubuntu8041.localdomain>
	<20080822104620.11984.30369.stgit@ubuntu8041.localdomain>
	<72120CFB-62D9-44B0-AD4F-26332C90F3C9@kernel.crashing.org>
	<20080822121152.70f01597.martyn.welch@gefanuc.com>
	<20080822122601.162dddd4.martyn.welch@gefanuc.com>
	<20080822171135.GA15623@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 22 Aug 2008 12:11:35 -0500
Scott Wood <scottwood@freescale.com> wrote:

> On Fri, Aug 22, 2008 at 12:26:01PM +0100, Martyn Welch wrote:
> > > > drop device_type.
> > > > 
> > > 
> > > Ah - _all_ device_type!
> > > 
> > 
> > Um, not all - just the ones where the name of the block matches the
> > device type(?)
> 
> All except "cpu" and "memory".
> 
> -Scott

And, it would appear, "soc" as well.

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
