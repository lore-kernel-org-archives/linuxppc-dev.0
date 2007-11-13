Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CA24DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 00:48:55 +1100 (EST)
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] cell: Convert #include of asm/of_{platform,
	device}.h into linux/of_{platform, device}.h.
In-Reply-To: Your message of "Tue, 13 Nov 2007 12:02:24 +1100."
	<20071113120224.de390904.sfr@canb.auug.org.au>
References: <1194899211.3396.15.camel@ld0161-tx32>
	<20071113120224.de390904.sfr@canb.auug.org.au>
Date: Tue, 13 Nov 2007 07:48:50 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Irw8I-0000b4-5e@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Stephen Rothwell mumbled:
> 
> Hi Jon,
> 
> Thanks for this.

Most welcome.

I'm assuming I can chip away at _all_ of these,
including the ones in the drivers/ directories as well.

I haven't a clue who will really pick all these up.
We could arrange for Paul to grab the arch/powerpc.
But the rest?  Mr Morton perhaps?

jdl
