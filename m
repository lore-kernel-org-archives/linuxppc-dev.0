Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE808DDDF7
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 08:12:47 +1000 (EST)
In-Reply-To: <46C9B6DF.1000006@freescale.com>
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>	<20070820060000.GA26100@localhost.localdomain>	<A4E8D00C-87DB-4C59-A6C4-70D437ED9988@kernel.crashing.org>
	<20070820103719.23f50f64@weaponx.rchland.ibm.com>
	<46C9B6DF.1000006@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <795532309eb785a667e66792fa722172@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 0/3 v2] Remove need for include/asm-ppc
Date: Tue, 21 Aug 2007 00:11:51 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> What would be the point of doing that?  I would think we want the
>> opposite, in that we want to reuse as much of arch/powerpc during
>> arch/ppc compiles as possible.  Sort of shows how much is "left" to
>> port.
>
> The point would be to keep the two trees separate, so that one doesn't
> need to worry about breaking arch/ppc when making a change to 
> arch/powerpc.

We should make arch/ppc as broken as possible so no one can
complain when it is finally removed.  I'll remove the config
from my auto-builder right now :-)


Segher
