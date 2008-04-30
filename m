Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18AF2DDF12
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 07:43:38 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Set lower flag bits in regs->trap to
	indicate debug level exception
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0804300544370.7714@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0804300544370.7714@blarg.am.freescale.net>
Content-Type: text/plain
Date: Thu, 01 May 2008 07:43:31 +1000
Message-Id: <1209591811.18023.234.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-30 at 05:44 -0500, Kumar Gala wrote:
> We use the low bits of regs->trap as flag bits.  We already indicate
> critical and machine check level exceptions via this mechanism.  Extend it
> to indicate debug level exceptions.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Ack.
