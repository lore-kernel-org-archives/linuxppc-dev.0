Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 0913767CEB
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 18:34:25 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k9Q8YOnl011478
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 01:34:24 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k9Q8YM6Y021164
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 03:34:23 -0500 (CDT)
Subject: Re: [PATCH] powerpc: Make pci_read_irq_line the default:
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <1161843365.5299.21.camel@localhost.localdomain>
References: <1161843365.5299.21.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1161851698.21511.8.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 26 Oct 2006 16:34:58 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-10-26 at 14:16, Benjamin Herrenschmidt wrote:

> Index: linux-work/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
> ===================================================================
> ---
> linux-work.orig/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c  
> 2006-10-09 12:03:33.000000000 +1000
> +++
> linux-work/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c       
> 2006-10-26 15:52:15.000000000 +1000

Paul,
	Please do not apply this part of patch. I will prove a new one to
update the irq map hopefully tomorrow.

Roy

	
