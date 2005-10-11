Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0510101449420.1572@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0510101449420.1572@nylon.am.freescale.net>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 17:46:11 +1000
Message-Id: <1129016771.17365.198.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: zero out BSS for all platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-10-10 at 14:51 -0500, Kumar Gala wrote:
> We need to ensure that the BSS is zeroed out for all platforms.
> Currently only prom_init.c was clearlying out the BSS which only works
> for PPC_OF platforms.
> 
> Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

You need to make absolutely certain that we have not written anything to
the bss yet though... Is that the case ? I usually prefer doing the
zero'ing in assembly :)

Ben.
