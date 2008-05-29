Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31FE8DDED7
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 16:37:26 +1000 (EST)
Subject: Re: [PATCH 4/6] Add ppc_function_entry() which gets the entry
	point for a function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <95ea86b673d9f1093abe4a54bc4ecc34a4ebcfac.1212042061.git.michael@ellerman.id.au>
References: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
	<95ea86b673d9f1093abe4a54bc4ecc34a4ebcfac.1212042061.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Thu, 29 May 2008 16:37:17 +1000
Message-Id: <1212043037.8888.48.camel@pasglop>
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

On Thu, 2008-05-29 at 16:20 +1000, Michael Ellerman wrote:
> Because function pointers point to different things on 32-bit vs
> 64-bit,
> add a macro that deals with dereferencing the OPD on 64-bit. The soon
> to
> be merged ftrace wants this, as well as other code I am working on.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Should we be smarter and also compare if the TOC pointer is the same
between the source and target and if not, warn loudly ?

Or we just don't care ?

Ben.
