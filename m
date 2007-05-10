Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD7D3DDE2F
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 15:19:42 +1000 (EST)
Date: Thu, 10 May 2007 00:15:01 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] Fix the PCI ranges in the MPC832x_MDS device tree.
In-Reply-To: <20070501174847.GA31612@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0705100014540.27791@localhost.localdomain>
References: <20070501174847.GA31612@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 1 May 2007, Scott Wood wrote:

> The MPC832x_MDS device tree's PCI non-prefetchable MMIO range was
> specified incorrectly.  Both the local and bus addresses start at
> 0x90000000.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc832x_mds.dts |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>

applied.

- k
