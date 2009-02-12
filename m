Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D2113DDE24
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 07:41:54 +1100 (EST)
Subject: Re: [PATCH] powerpc: rework dma-noncoherent to use generic
	vmap/vunmap functions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ilya Yanok <yanok@emcraft.com>
In-Reply-To: <49945EFE.8000401@emcraft.com>
References: <1231505915-16082-1-git-send-email-yanok@emcraft.com>
	<1233722625.16867.249.camel@pasglop>  <49945EFE.8000401@emcraft.com>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 07:41:34 +1100
Message-Id: <1234471294.29851.59.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> btw, ioremap doesn't provide useful 'caller').

I fixed that :-) (see patches I posted to the list, though that's
waiting for a patch to go upstream first that adds a
__get_vm_area_caller() that I need for ppc64).

Cheers,
Ben.
