Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id B09D267A84
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 04:24:33 +1100 (EST)
Date: Sun, 6 Feb 2005 10:24:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20050206172431.GB7686@smtp.west.cox.net>
References: <20050206125056.GA6394@suse.de>
	<20050206165428.GA7686@smtp.west.cox.net>
	<20050206165629.GA18769@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050206165629.GA18769@suse.de>
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

On Sun, Feb 06, 2005 at 05:56:29PM +0100, Olaf Hering wrote:
>  On Sun, Feb 06, Tom Rini wrote:
> 
> > On Sun, Feb 06, 2005 at 01:50:56PM +0100, Olaf Hering wrote:
> > 
> > > make ARCH=ppc tags leaves a .tmp_gas_check file behind.
> > > Just remove it after the as test.
> > > 
> > > Signed-off-by: Olaf Hering <olh@suse.de>
> > 
> > What is the problem exactly?  .tmp_* should be removed in a normal
> > 'clean' target ?
> 
> make tags should only create the toplevel tags file, nothing else.

My first guess then is there's a dependancy problem, as make tags should
just invoke ctags or so, yes?

-- 
Tom Rini
http://gate.crashing.org/~trini/
