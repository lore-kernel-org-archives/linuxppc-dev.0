Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id ADEE62BDD3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2004 04:17:56 +1000 (EST)
Date: Mon, 20 Sep 2004 11:17:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Message-ID: <20040920181747.GN27914@smtp.west.cox.net>
References: <20040917100643.53011.qmail@web15608.mail.cnb.yahoo.com>
	<414AB4A7.2000807@intracom.gr>
	<20040920174914.GM27914@smtp.west.cox.net>
	<Pine.LNX.4.60.0409201400030.5204@dell.enoriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0409201400030.5204@dell.enoriver.com>
Cc: Linuxppc-dev mailing list <linuxppc-dev@ozlabs.org>
Subject: Re: Linux 2.6.x on 8xx status
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 20, 2004 at 02:02:43PM -0400, Robert P. J. Day wrote:

> On Mon, 20 Sep 2004, Tom Rini wrote:
> 
> >Note that the old SCC enet driver, in linuxppc-2.5 at least is 'OK'.
> >Not that it couldn't do with a cleanup and netdev person audit, but it's
> >functional enough for me and my rpxlite to mount a root fs.
> 
> sorry to jump into this conversation late -- which "2.6.x" source tree 
> is being used here?

As I said, linuxppc-2.5 is where the working driver is right now.

> for quite some time, i've just used the linuxppx-2.5 tree at 
> ppc.bkbits.net.  but when someone refers to a 2.6.x tree, which one 
> specifically is this?  just the latest BK update from www.kernel.org?
> or is this a PPC-specific tree?

The only trees that matter here are linuxppc-2.5 (on ppc.bkbits.net) and
linux-2.6 (on linux.bkbits.net).  Everthing else "2.6.x" is a snapshot
of one form or another of the linux-2.6 tree.

-- 
Tom Rini
http://gate.crashing.org/~trini/
