Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABD4CDDE2D
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 07:18:02 +1000 (EST)
Subject: Re: [PATCH] Quieten cache information at boot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20071014193317.GC26693@kryten>
References: <20071014193317.GC26693@kryten>
Content-Type: text/plain
Date: Mon, 15 Oct 2007 07:17:51 +1000
Message-Id: <1192396671.6188.6.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-10-14 at 14:33 -0500, Anton Blanchard wrote:
> After 6 years the ppc64 kernel still thinks its important to tell me my
> cache line size is 0x80 bytes. I think most people who care know that by
> now. The rest probably cant even understand the hex output.
> 
> Since we might have misconfigured firmware or cpus that have a linesize
> that isnt 128 bytes, I still print it out for those cases. If people
> would prefer to remove it completely, lets do it.
> 
> Also for lpar remove the htab_address printout since its not used.

Why not also make those KERN_DEBUG ?

Ben.
