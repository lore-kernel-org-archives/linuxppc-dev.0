Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34A3967B54
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jun 2006 08:19:03 +1000 (EST)
Subject: Re: secondary CPU kicking on 86xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1FrFmI-0002Vn-UE@jdl.com>
References: <E1FrFmI-0002Vn-UE@jdl.com>
Content-Type: text/plain
Date: Sat, 17 Jun 2006 08:18:49 +1000
Message-Id: <1150496329.23600.54.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Or we can dynamically rewrite a branch instruction into
> the reset vector from C code during smp_kick_cpu() time
> like the current powermac code does.
> 
> I have working code for both; just need opinions
> and preferences on correct approach/style voiced!

Second approach. #ifdef are evil and they prevent multiple board support
in the same kernel.

Ben.
