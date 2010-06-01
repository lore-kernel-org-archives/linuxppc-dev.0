Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BDF0DB7D51
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jun 2010 09:50:33 +1000 (EST)
Subject: Re: [PATCH] powerpc: Optimise per cpu accesses on 64bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Modra <amodra@gmail.com>
In-Reply-To: <20100601224026.GG5631@bubble.grove.modra.org>
References: <20100601044511.GF28295@kryten> <1275375920.1931.699.camel@pasglop>
	<20100601224026.GG5631@bubble.grove.modra.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 09:50:21 +1000
Message-ID: <1275436221.1931.725.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-06-02 at 08:10 +0930, Alan Modra wrote:
> Not r12.  It is used in function prologue and epilogue code.  If you
> want a dedicated gpr I think you'll need to use (and lose) one of the
> non-volatile regs. 

Which would probably not be a big deal... 

Cheers,
Ben.
