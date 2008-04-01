Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57EFFDE16C
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 08:01:26 +1100 (EST)
Date: Tue, 1 Apr 2008 14:00:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: York Sun <yorksun@freescale.com>
Subject: Re: [PATCH 2/2 v5] Add DIU platform code for MPC8610HPCD
Message-Id: <20080401140029.be918d87.akpm@linux-foundation.org>
In-Reply-To: <12069806051291-git-send-email-yorksun@freescale.com>
References: <12069806051060-git-send-email-yorksun@freescale.com>
	<1206980605689-git-send-email-yorksun@freescale.com>
	<12069806051291-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: timur@freescale.com, linux-fbdev-devel@lists.sourceforge.net,
	a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 31 Mar 2008 11:23:25 -0500
York Sun <yorksun@freescale.com> wrote:

> Add platform code to support Freescale DIU. The platform code includes
> framebuffer memory allocation, pixel format, monitor port, etc.
> 
> Signed-off-by: York Sun <yorksun@freescale.com>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> This patch addes platform support for Freescale DIU driver, targeting 2.6.26 kernel.
> 
>  arch/powerpc/configs/mpc8610_hpcd_defconfig |  198 +++++++++++++++++++++++----
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c  |  190 ++++++++++++++++++++++++--
>  arch/powerpc/sysdev/fsl_soc.c               |   41 ++++++
>  arch/powerpc/sysdev/fsl_soc.h               |   23 +++
>  4 files changed, 413 insertions(+), 39 deletions(-)

The defconfig change gets almost 100% rejects and probably isn't
appropriate here and isn't very important.  I dropped that part of the
patch.
