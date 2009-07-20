Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1FD8EB7B84
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 20:11:09 +1000 (EST)
Subject: Re: Simple question about powerpc kernel source.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: HongWoo Lee <hongwoo7@gmail.com>
In-Reply-To: <4A643219.3070004@gmail.com>
References: <4A643219.3070004@gmail.com>
Content-Type: text/plain
Date: Mon, 20 Jul 2009 20:02:38 +1000
Message-Id: <1248084158.30899.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-07-20 at 18:00 +0900, HongWoo Lee wrote:
> Hi all,
> 
> I have something to ask for the ppc kernel source.
> 
> #define LOADADDR(rn,name)           \
>     lis     rn,name##@highest;      \
>     ori     rn,rn,name##@higher;    \
>     rldicr  rn,rn,32,31;            \
>     oris    rn,rn,name##@h;         \
>     ori     rn,rn,name##@l
> 
> Is ## used for concatenation. I'm not sure because it is just meaningless.
> If so what on earth is the result of concatenating ?
> 
> And is there a good reference to understand powerpc asm ?
> I'm reading Power ISA, but I can't find @highest, @higher and ##.
> It would be good to know the reference book.

You already asked pretty much the same question with the subject "Simple
question about powerpc asm" and it was already replied to.

Cheers,
Ben.
