Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id C3AFA68809
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 09:34:03 +1100 (EST)
Date: Mon, 28 Nov 2005 15:34:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-embedded@ozlabs.org
Message-ID: <20051128223401.GB7766@smtp.west.cox.net>
References: <20051124213821.GA21929@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051124213821.GA21929@gate.ebshome.net>
Subject: Re: [PATCH] ppc32: fix treeboot image entrypoint
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Nov 24, 2005 at 01:38:21PM -0800, Eugene Surovegin wrote:

> Correctly specify treeboot based image entrypoint. Currently makefile 
> uses $(ENTRYPOINT) which isn't defined anywhere. Each board port sets 
> entrypoint-$(CONFIG_BOARD_NAME) instead.
> 
> Without this patch I cannot boot Ocotea (PPC440GX eval board) anymore. 
> I was getting random "OS panic" errors from OpenBIOS for a while, but 
> with current kernel I get them all the time (probably because image 
> became bigger).
> 
> Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

I wonder how that got lost when I think ENTRYPOINT was changed to
entrypoint-$(board_name).  Maybe we should also think about changing the
default entry point in mktreeboot.c, what do you think Eugene? or Matt?

Acked-by: Tom Rini <trini@kernel.crashing.org>

-- 
Tom Rini
http://gate.crashing.org/~trini/
