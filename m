Return-Path: <olh@suse.de>
Date: Tue, 11 Oct 2005 11:30:40 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051011093040.GA5362@suse.de>
References: <Pine.LNX.4.61.0510101449420.1572@nylon.am.freescale.net>
	<1129016771.17365.198.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1129016771.17365.198.camel@gaston>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <galak@freescale.com>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: zero out BSS for all platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Tue, Oct 11, Benjamin Herrenschmidt wrote:

> On Mon, 2005-10-10 at 14:51 -0500, Kumar Gala wrote:
> > We need to ensure that the BSS is zeroed out for all platforms.
> > Currently only prom_init.c was clearlying out the BSS which only works
> > for PPC_OF platforms.
> > 
> > Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>
> 
> You need to make absolutely certain that we have not written anything to
> the bss yet though... Is that the case ? I usually prefer doing the
> zero'ing in assembly :)

early_init is called so early, its almost like asm code.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
