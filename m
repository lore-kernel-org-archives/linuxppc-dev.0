Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75A64DDF7C
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 07:48:55 +1100 (EST)
Subject: Re: [PATCH 8/16] powerpc/mm: Rename tlb_32.c and tlb_64.c to
	tlb_hash32.c and tlb_hash64.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <636BC2D5-0606-4558-AFEC-436835774867@freescale.com>
References: <20081215054539.2B9B8DDFB4@ozlabs.org>
	<636BC2D5-0606-4558-AFEC-436835774867@freescale.com>
Content-Type: text/plain
Date: Tue, 16 Dec 2008 07:46:45 +1100
Message-Id: <1229374005.26324.121.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-15 at 14:36 -0600, Kumar Gala wrote:
> 
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
> 
> (I'm told git-format-patch -M is useful for such patches)

I'm still using quilt for my own developement.

Cheers,
Ben.
