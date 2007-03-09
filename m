Return-Path: <SRS0+4f1e0d28af8560107a14+1293+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B0A9DDEBF
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 04:21:18 +1100 (EST)
Subject: Re: [PATCH] Complain about missing system calls.
From: David Woodhouse <dwmw2@infradead.org>
To: Andi Kleen <andi@firstfloor.org>
In-Reply-To: <p737itqbdnl.fsf@bingen.suse.de>
References: <1173394873.3461.510.camel@pmac.infradead.org>
	<p737itqbdnl.fsf@bingen.suse.de>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 17:20:02 +0000
Message-Id: <1173460802.12760.2.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sam@ravnborg.org, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-03-09 at 17:11 +0100, Andi Kleen wrote:
> Of course the existing syscall numbers can't be changed, but for all new 
> calls one could just add automatically for everybody.
> 
> A global table with two entries (compat and non compat) and a per arch 
> override table should be sufficient.

Counterexample: sys_epoll_pwait.

It'd be nice if it were that simple.

It'd also be nice if people stopped thinking it was that simple :)

-- 
dwmw2
