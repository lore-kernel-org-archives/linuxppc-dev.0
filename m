Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 41EBA2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 01:52:18 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc: Convert platforms to smp_generic_cpu_bootable
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1374789726-10633-2-git-send-email-afleming@freescale.com>
Date: Fri, 26 Jul 2013 10:48:41 -0500
Message-Id: <1A6DB245-DD3F-4FCD-B850-77CAF5BCC233@kernel.crashing.org>
References: <1374789726-10633-1-git-send-email-afleming@freescale.com>
 <1374789726-10633-2-git-send-email-afleming@freescale.com>
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 25, 2013, at 5:02 PM, Andy Fleming wrote:

> T4, Cell, powernv, and pseries had the same implementation, so switch
> them to use a generic version. A2 apparently had a version, but
> removed it at some point, so we remove the declaration, too.
> 
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> 
> Conflicts:
> 
> 	arch/powerpc/platforms/cell/smp.c
> 	arch/powerpc/platforms/powernv/smp.c
> 	arch/powerpc/platforms/pseries/smp.c
> 
> Change-Id: If12e2f83f7187ee5982dca9f89c68e0600f0cc49

clean this up for sending upstream.

- k

> ---
> arch/powerpc/platforms/85xx/smp.c    |    1 +
> arch/powerpc/platforms/cell/smp.c    |   15 +--------------
> arch/powerpc/platforms/powernv/smp.c |   18 +-----------------
> arch/powerpc/platforms/pseries/smp.c |   18 +-----------------
> arch/powerpc/platforms/wsp/wsp.h     |    1 -
> 5 files changed, 4 insertions(+), 49 deletions(-)
