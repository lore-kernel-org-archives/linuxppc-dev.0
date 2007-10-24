Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2037DDEF0
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 07:56:21 +1000 (EST)
Subject: Re: New time code miscalculates cpu usage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <471FA875.6080602@ru.mvista.com>
References: <20071016202525.GA11837@lixom.net> <471FA875.6080602@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 25 Oct 2007 07:56:09 +1000
Message-Id: <1193262969.6653.32.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-10-25 at 00:17 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Olof Johansson wrote:
> 
> > Not sure when this started happening, but I wanted to report it. I'll
> > start bisecting in a day or two if noone else has gotten around to
> > looking at it:
> 
> > $ echo "int main(void) { while(1); }" > test.c ; gcc test.c
> > $ time ./a.out & sleep 2 ; killall a.out
> > real    0m2.008s
> > user    0m4.014s
> > sys     0m0.002s
> > 
> > Seen on POWER5 and PA6T, haven't tried anything else yet.
> 
>     I'm not surprised -- the kernel accounts twice for each tick.

Your input would be much more valuable if you actually pointed out where
that happens and why since you seem to know it.

Ben.
