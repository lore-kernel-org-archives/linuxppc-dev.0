Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 54D8FDDE10
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 11:07:43 +1100 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [POWERPC] 86xx: Cleaned up platform dts files 
In-Reply-To: Your message of "Sat, 17 Feb 2007 16:32:18 CST."
	<Pine.LNX.4.64.0702171631150.11585@localhost.localdomain>
References: <Pine.LNX.4.64.0702171631150.11585@localhost.localdomain> 
Date: Sat, 17 Feb 2007 18:07:38 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HIZac-0003HQ-LI@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Kumar Gala mumbled:
> * Removed explicit linux,phandle usage. Use references and labels now
> * Removed interrupts property from openpic node
> * Removed interrupt-parent property from openpic node that pointed to itself
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Sweet.

Acked-by: Jon Loeliger <jdl@freescale.com>

Thanks,
jdl
