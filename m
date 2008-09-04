Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-7.online-age.net (ext-nj2ut-7.online-age.net
	[64.14.54.237])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 01D6C4762A
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 01:41:57 +1000 (EST)
Received: from int-nj2ut-3.online-age.net (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by ext-nj2ut-7.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m84Ffqrk030043
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 11:41:52 -0400
Received: from alpmlip01.e2k.ad.ge.com (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by int-nj2ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m84Ffq22017742
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 11:41:52 -0400
Date: Thu, 4 Sep 2008 16:41:08 +0100
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Subject: Re: [PATCH v3 1/2] powerpc: Board support for GE Fanuc SBC610
Message-Id: <20080904164108.098f7a0e.martyn.welch@gefanuc.com>
In-Reply-To: <48BF1D2B.7000408@gmail.com>
References: <20080826131339.12883.61796.stgit@ubuntu8041.localdomain>
	<20080826131344.12883.60435.stgit@ubuntu8041.localdomain>
	<7E18A542-EA62-4F5B-992C-8AC3D9562F72@kernel.crashing.org>
	<20080901093529.3a4371f7.martyn.welch@gefanuc.com>
	<48BF1D2B.7000408@gmail.com>
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

On Wed, 03 Sep 2008 19:26:35 -0400
Jerry Van Baren <gvb.linuxppc.dev@gmail.com> wrote:

> Martyn Welch wrote:
> > On Fri, 29 Aug 2008 07:04:18 -0500
> > Kumar Gala <galak@kernel.crashing.org> wrote:
> >> what u-boot version are you using/shipping with these boards?
> > 
> > U-boot 1.2.0
> 
> 1.2.0 predates the libfdt support.  You probably don't have any fdt 
> support in your u-boot (if you do, it is old and crude and probably 
> doesn't any of the fixups that Kumar refers to).
> 
> I would strongly recommend you upgrade to the tip o' the tree or at 
> least the latest release (1.3.4).  FDT support will be *much* better - 
> we now has generic utility routines that fix up lots of stuff for you 
> rather than the crufty by-hand fixups (if any) from the 1.2.0 timeframe.
> 

Unfortunately that's not something I have the power to do. I'm stuck with 1.2.0.

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
