Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BBE8DB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 31 Oct 2010 07:47:37 +1100 (EST)
Subject: Re: [MPC8xx] Initial MMU too low
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: LEROY christophe <christophe.leroy@c-s.fr>
In-Reply-To: <4CCC06F8.3020506@c-s.fr>
References: <4CCC06F8.3020506@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 31 Oct 2010 07:47:28 +1100
Message-ID: <1288471648.7329.5.camel@pasglop>
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

On Sat, 2010-10-30 at 13:52 +0200, LEROY christophe wrote:
> Hello,
> 
> When I build a kernel with DEBUG_LOCK_ALLOC set, I get a kernel which 
> has __bss_stop above the C0800000 limit, and then I get a bad page 
> exception during the zeroize of the __bss at startup, because the 
> initial MMU only maps the first 8Mbytes.
> 
> What can I do to fix that ?

Not much... maybe pin more initial TLBs ?

Ben.
