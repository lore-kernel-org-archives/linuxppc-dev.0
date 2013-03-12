Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DB60B2C0325
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 08:14:43 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: add CONFIG_E1000E to corenet64_smp_defconfig
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20130312200340.GA22145@home.buserror.net>
Date: Tue, 12 Mar 2013 16:14:38 -0500
Message-Id: <7A07C158-C9BE-4A76-952D-DB1B3D43CAC9@kernel.crashing.org>
References: <20130312200340.GA22145@home.buserror.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 12, 2013, at 3:03 PM, Scott Wood wrote:

> This is a commonly used ethernet card, especially with mainline kernels
> which lack datapath support.o
> 
> Other changes are due to running savedefconfig.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> 
> arch/powerpc/configs/corenet64_smp_defconfig |    6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)

fixed up and applied to next

- k
