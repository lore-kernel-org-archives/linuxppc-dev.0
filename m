Return-Path: <mikey@ozlabs.org>
To: michael@ellerman.id.au
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Make RTAS console init generic 
In-reply-to: <1155780267.6910.3.camel@localhost.localdomain> 
References: <20060816194225.C9F1F67B32@ozlabs.org>
	<1155780267.6910.3.camel@localhost.localdomain>
Date: Wed, 16 Aug 2006 22:27:15 -0500
Sender: mikey@ozlabs.org
Message-Id: <20060817032723.25A2767B6D@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Seems to work fine on Cell.

Kewl

> > Updated Kconfig so we can enable it. 
> 
> I enable it via the early debugging menu (under kernel hacking), is that
> not good enough?

Doesn't that enable CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE not
CONFIG_UDBG_RTAS_CONSOLE?

Without the Kconfig update you don't seem to get presented with an
option but I'm no kbuild expert.

> >  config UDBG_RTAS_CONSOLE
> > -	bool
> > +	bool "RTAS based debug console"
> >  	default n
> 
> This should probably depend on RTAS?

Yeap.

Mikey
