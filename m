Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3208DDDDB
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 08:50:05 +1000 (EST)
Subject: Re: [PATCH] powerpc: Reserve syscall number 319
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080902221208.GA11712@lixom.net>
References: <20080902054941.77DA3DDDF0@ozlabs.org>
	<20080902180605.GA8240@lixom.net> <1220389575.13010.149.camel@pasglop>
	<20080902213044.GA11416@lixom.net> <1220392150.13010.178.camel@pasglop>
	<20080902221208.GA11712@lixom.net>
Content-Type: text/plain
Date: Wed, 03 Sep 2008 08:49:58 +1000
Message-Id: <1220395798.13010.181.camel@pasglop>
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


> Then don't try to reserve a system call to be used only by an out-of-tree,
> proprietary kernel extension. Which your kernel change in essence is
> until it's released.
> 
> Would we accept a system call number reservation that was submitted by,
> say, nVidia? No? Well, there you go.
> 
> It's really that simple.

Well, except that nvidia has no intention to release :-)

Anyway, it's a moot point, I have the answer I needed...

Cheers,
Ben.
