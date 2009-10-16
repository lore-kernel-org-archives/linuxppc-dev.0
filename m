Return-Path: <Kim.Phillips@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96DB5B7BAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Oct 2009 09:27:51 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9GMRWrX010301 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Oct 2009 15:27:43 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n9GMU5wR028448
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Oct 2009 17:30:05 -0500 (CDT)
Date: Fri, 16 Oct 2009 17:27:27 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Roland Lezuo <roland.lezuo@chello.at>
Subject: Re: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
Message-Id: <20091016172727.841cce53.kim.phillips@freescale.com>
In-Reply-To: <1255635643.20355.2.camel@tbfg-desktop>
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
	<20090909182227.GA8215@b07421-ec1.am.freescale.net>
	<F7AA2B23-A019-4E11-993D-AF0F6F1FD50A@kernel.crashing.org>
	<20091012110619.972d0f61.kim.phillips@freescale.com>
	<1255635643.20355.2.camel@tbfg-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, u-boot@lists.denx.de,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 15 Oct 2009 21:40:43 +0200
Roland Lezuo <roland.lezuo@chello.at> wrote:

> On Mon, 2009-10-12 at 11:06 -0500, Kim Phillips wrote:
> > On Wed, 9 Sep 2009 15:28:01 -0500
> > Kumar Gala <galak@kernel.crashing.org> wrote:
> > > On Sep 9, 2009, at 1:22 PM, Scott Wood wrote:
> > > > We really should have a u-boot fixup based on SVR.
> > 
> > Roland, is it possible for you to test this u-boot patch?:
> 
> No sorry, I have no MPC8313ERDB at hands. But the patch at least looks
> good...

ok, thanks - I went ahead and applied it anyway; it'll be tested by
the next u-boot release.  I've added your reviewed-by.

Kim
