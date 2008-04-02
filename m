Return-Path: <yorksun@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 876DBDDF43
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 00:27:51 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m32DRklS018413
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 06:27:46 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m32DRjD8014492
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Apr 2008 08:27:45 -0500 (CDT)
Subject: Re: [PATCH 2/2 v5] Add DIU platform code for MPC8610HPCD
From: York Sun <yorksun@freescale.com>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080401140029.be918d87.akpm@linux-foundation.org>
References: <12069806051060-git-send-email-yorksun@freescale.com>
	<1206980605689-git-send-email-yorksun@freescale.com>
	<12069806051291-git-send-email-yorksun@freescale.com>
	<20080401140029.be918d87.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 02 Apr 2008 08:27:43 -0500
Message-Id: <1207142863.20695.19.camel@laptop>
Mime-Version: 1.0
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-04-01 at 14:00 -0700, Andrew Morton wrote:
> On Mon, 31 Mar 2008 11:23:25 -0500
> York Sun <yorksun@freescale.com> wrote:
> 
> > Add platform code to support Freescale DIU. The platform code includes
> > framebuffer memory allocation, pixel format, monitor port, etc.
> > 
> > Signed-off-by: York Sun <yorksun@freescale.com>
> > Signed-off-by: Timur Tabi <timur@freescale.com>
> > ---
> > This patch addes platform support for Freescale DIU driver, targeting 2.6.26 kernel.
> > 
> >  arch/powerpc/configs/mpc8610_hpcd_defconfig |  198 +++++++++++++++++++++++----
> >  arch/powerpc/platforms/86xx/mpc8610_hpcd.c  |  190 ++++++++++++++++++++++++--
> >  arch/powerpc/sysdev/fsl_soc.c               |   41 ++++++
> >  arch/powerpc/sysdev/fsl_soc.h               |   23 +++
> >  4 files changed, 413 insertions(+), 39 deletions(-)
> 
> The defconfig change gets almost 100% rejects and probably isn't
> appropriate here and isn't very important.  I dropped that part of the
> patch.
> 

It's OK.

York
