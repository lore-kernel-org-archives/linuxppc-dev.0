Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1B298DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 01:59:12 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAKEwhNG003470
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 09:58:43 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAKEwx1V158126
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 09:58:59 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAKFx7Vm013620
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 10:59:07 -0500
Date: Thu, 20 Nov 2008 09:58:41 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Re: Please pull 'merge' branch of powerpc-4xx git tree
Message-ID: <20081120095841.7111fd45@zod.rchland.ibm.com>
In-Reply-To: <20081113153623.GA2299@yoda.jdub.homelinux.org>
References: <20081113153623.GA2299@yoda.jdub.homelinux.org>
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

On Thu, 13 Nov 2008 10:36:23 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> Hi Paul,
> 
> Please pull the merge branch of the powerpc-4xx git tree.  It contains
> two small fixes that should go into .28.

Ping?

josh

> The following changes since commit cb8fdc69a2a80e81e1280ec58afd2c3217ac8a7f:
>   Paul Mackerras (1):
>         powerpc: Update desktop/server defconfigs
> 
> are available in the git repository at:
> 
>   ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git merge
> 
> Benjamin Herrenschmidt (1):
>       powerpc/44x: Fix 460EX/460GT machine check handling
> 
> Grant Erickson (1):
>       powerpc/40x: Limit allocable DRAM during early mapping
> 
>  arch/powerpc/kernel/cpu_setup_44x.S |    7 ++++++-
>  arch/powerpc/mm/40x_mmu.c           |   16 ++++++++++++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
