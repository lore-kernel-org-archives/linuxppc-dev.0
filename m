Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11676DE089
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 13:04:33 +1000 (EST)
Subject: Re: [PATCH 1/2] [v3][POWERPC] refactor dcr code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40804181930s724b2e11we01943236ec0b8a7@mail.gmail.com>
References: <1206914576.10388.132.camel@pasglop>
	<20080418215513.ACA0C17F007A@mail131-dub.bigfish.com>
	<fa686aa40804181930s724b2e11we01943236ec0b8a7@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 19 Apr 2008 13:04:26 +1000
Message-Id: <1208574266.6958.441.camel@pasglop>
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


> By current conventions; these should probably be static functions (but
> don't make them inline).  The compiler will do the right thing with
> them.  Functions are easier to validate by the compiler and sparse
> than #defines.

Not necessarily... yes we tend to prefer functions, but in that case
which is 100% a renaming trick, macros are fine and somewhat simpler.

There is no type difference and the macro will not prevent type checking
here.

Cheers,
Ben.
