Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id DD3DE67A83
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 07:04:33 +1100 (EST)
Date: Sun, 6 Feb 2005 13:04:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20050206200431.GC7686@smtp.west.cox.net>
References: <20050206125056.GA6394@suse.de>
	<20050206165428.GA7686@smtp.west.cox.net>
	<20050206165629.GA18769@suse.de>
	<20050206172431.GB7686@smtp.west.cox.net>
	<20050206172552.GC19327@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050206172552.GC19327@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] remove .tmp_gas_check
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 06, 2005 at 06:25:52PM +0100, Olaf Hering wrote:
>  On Sun, Feb 06, Tom Rini wrote:
> 
> > My first guess then is there's a dependancy problem, as make tags should
> > just invoke ctags or so, yes?
> 
> The variable is evaluated, even if it is not used.
> Just run 'make ARCH=ppc tags' and see yourself.

Right.  But we only care about that if we're going to compile anything,
so perhaps we need to change the test somehow to only get evaluated when
needed (ala the -mcpu stuff?  Or is that always run as well?).

-- 
Tom Rini
http://gate.crashing.org/~trini/
