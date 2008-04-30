Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6AFDEDDEF6
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:18:22 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
References: <Pine.LNX.4.64.0804300424040.31028@blarg.am.freescale.net>
	<1209592495.18023.246.camel@pasglop>
	<12ECF63E-7CEA-48FD-9447-7D534C29271D@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 01 May 2008 08:18:16 +1000
Message-Id: <1209593896.18023.253.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-30 at 17:13 -0500, Kumar Gala wrote:
> >>  stack there by make references go from GPR11-INT_FRAME_SIZE(r8) to
> >>  just GPR(r8)
> >            ^^ 11 ?
> 
> r8 is correct for my example.  My point is
> s/GPR11-INT_FRAME_SIZE/GPR11/

Sorry, I put the ^^ in the wrong place :-) I meant the example should
say GPR11(r8)

Ben.
