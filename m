Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-12.online-age.net (ext-nj2ut-12.online-age.net
	[64.14.54.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BC554DE368
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 00:58:49 +1000 (EST)
Received: from int-nj2ut-3.online-age.net (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by ext-nj2ut-12.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m8UEwdWx023824
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 10:58:39 -0400
Received: from alpmlip01.e2k.ad.ge.com (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by int-nj2ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m8UEwda7026568
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 10:58:39 -0400
Date: Tue, 30 Sep 2008 16:00:30 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: GE Fanuc's FPGA based PIC controller on the
	SBC610
Message-Id: <20080930160030.4c0d5903.martyn.welch@gefanuc.com>
In-Reply-To: <E3BAFDF8-561A-47E9-8286-922929D908AE@kernel.crashing.org>
References: <20080930142942.28193.943.stgit@ubuntu8041.localdomain>
	<E3BAFDF8-561A-47E9-8286-922929D908AE@kernel.crashing.org>
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

On Tue, 30 Sep 2008 09:50:58 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:
> 
> On Sep 30, 2008, at 9:29 AM, Martyn Welch wrote:
> 
> >
> > arch/powerpc/boot/dts/gef_sbc610.dts     |   38 ++++
> > arch/powerpc/platforms/86xx/gef_sbc610.c |   25 +++
> > arch/powerpc/sysdev/Makefile             |    2
> > arch/powerpc/sysdev/gef_pic.c            |  258 +++++++++++++++++++++ 
> > +++++++++
> > arch/powerpc/sysdev/gef_pic.h            |   11 +
> 
> The gef_pic should really live in platforms/86xx/ since its specific  
> to your board.
> 

Ah, ok. I'll move it and resubmit.

> - k


-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
