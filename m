Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C19E4B7B69
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 10:54:28 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix __flush_icache_range on 44x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090818001614.GG3095@hansolo.jdub.homelinux.org>
References: <20090817134136.GB8710@zod.rchland.ibm.com>
	<20090817160713.GE8710@zod.rchland.ibm.com>
	<1250545588.4861.5.camel@pasglop>
	<20090818001614.GG3095@hansolo.jdub.homelinux.org>
Content-Type: text/plain
Date: Tue, 18 Aug 2009 10:54:09 +1000
Message-Id: <1250556849.4830.64.camel@pasglop>
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

On Mon, 2009-08-17 at 20:16 -0400, Josh Boyer wrote:
> 
> You can if you'd like.  My biggest concern is getting time to
> recreate.  I
> think I'll have time later in the week if you'd like to wait until
> then.
> I simply didn't want to send out a patch that I wasn't sure fixed the
> issue.
> 
That's ok. It's a bug fix so it's less constrained by the upcoming merge
window and we can send it back to -stable later.

Cheers,
Ben.
