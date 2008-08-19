Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DBC50DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 11:59:14 +1000 (EST)
Subject: Re: Finding cpuid in entry_64.S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mitesh R. Meswani" <mmeswani@miners.utep.edu>
In-Reply-To: <BLU103-DS41DBE50328F80B52EA442936E0@phx.gbl>
References: <BLU103-DS41DBE50328F80B52EA442936E0@phx.gbl>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 11:59:07 +1000
Message-Id: <1219111147.8062.6.camel@pasglop>
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

On Mon, 2008-08-18 at 17:33 -0600, Mitesh R. Meswani wrote:
> Hello 
>  
> I am trying to find the cpuid when the functions that handle return
> from context switch and interrupts are called, based on the cpu the
> return code is executing on, I want to take some specific actions. 

What are you trying to do more precisely ? It sounds like the wrong
solution to whatever problem you have ... 

Ben.
