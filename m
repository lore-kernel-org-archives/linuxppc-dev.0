Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 9B5A168287
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Sep 2005 02:23:39 +1000 (EST)
Date: Sat, 10 Sep 2005 09:23:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Tobias Klauser <tklauser@nuerscht.ch>
Message-ID: <20050910162337.GA17038@smtp.west.cox.net>
References: <20050910121633.GC1218@neon.tklauser.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050910121633.GC1218@neon.tklauser.home>
Cc: akpm@osdl.org, kernel-janitors@lists.osdl.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/4] arch/ppc: Replace custom macro with isdigit()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 10, 2005 at 02:16:33PM +0200, Tobias Klauser wrote:

> Replace the custom is_digit() macro with isdigit() from <linux/ctype.h>
> 
> Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>

NAK, in the boot code we don't want to be adding dependanies on external
things without good reason to.

-- 
Tom Rini
http://gate.crashing.org/~trini/
