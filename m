Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D501DDDE6
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 14:25:35 +1100 (EST)
Date: Sun, 11 Mar 2007 22:22:17 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Subject: Re: [patch]: Unify PCI Express memory map registers structure define
In-Reply-To: <1173418047.20626.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0703112219470.13066@localhost.localdomain>
References: <1173161436.9465.91.camel@localhost.localdomain>
	<1173418047.20626.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 9 Mar 2007, Zang Roy-r61911 wrote:

> Unify PCI Express memory map registers structure define
> to arch/pwoerpc/sysdev/fsl_pcie.h for Freescale 85xx/86xx
> processor family.
> arch/ppc will not support PCI Express for 85xx/86xx.
>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---

applied.

- k
