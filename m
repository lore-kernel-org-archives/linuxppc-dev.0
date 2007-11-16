Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84E58DDEC1
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 08:09:42 +1100 (EST)
Subject: Re: [POWERPC] [RFC] Fix 8xx tlbie definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071116112822.37a238c0@weaponx>
References: <20071116112822.37a238c0@weaponx>
Content-Type: text/plain
Date: Sat, 17 Nov 2007 08:06:29 +1100
Message-Id: <1195247189.28865.174.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-16 at 11:28 -0600, Josh Boyer wrote:
> Git commit e701d269aa28996f3502780951fe1b12d5d66b49 introduced an incorrect
> definition for _tlbie on PowerPC 8xx platforms.  Only the address should be
> passed to the function.  This patch corrects the definition of _tlbie and the
> related tlb flushing functions for 8xx.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

That conflicts with the patch I posted to fix it differently (I kept the
additional argument).

Which one do we take ?

Ben.
