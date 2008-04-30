Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18455.59014.305281.949578@cargo.ozlabs.ibm.com>
Date: Wed, 30 Apr 2008 13:24:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] convert transfer_to_handler into a macro
In-Reply-To: <73CD5806-5CE4-40A7-957B-8F164E26FAFB@kernel.crashing.org>
References: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
	<18455.37613.709102.30668@cargo.ozlabs.ibm.com>
	<73CD5806-5CE4-40A7-957B-8F164E26FAFB@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> > Wouldn't it be better and safer to have the exception prolog for
> > critical interrupts save SRR0/1 in the stack frame, and have the
> > prolog for machine checks save SRR0/1 and CSRR0/1 likewise?
> 
> If we do this I guess we can use SRR0/1 regardless of which level we  
> came from.

That's the idea.  I actually thought the booke exception prologs
already did that, but it seems I'm wrong.

What sort of things do you expect critical and machine-check handlers
to be needing to do?

Paul.
