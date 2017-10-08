Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y8xjd5lTgzDqY1
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Oct 2017 19:43:33 +1100 (AEDT)
In-Reply-To: <20170918141658.27948-1-gpiccoli@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: muvic@linux.vnet.ibm.com, paulus@samba.org, gpiccoli@linux.vnet.ibm.com
Subject: Re: powerpc/xmon: Add option to show uptime information
Message-Id: <3y8xjd3XFqz9t5C@ozlabs.org>
Date: Sun,  8 Oct 2017 19:43:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-09-18 at 14:16:58 UTC, "Guilherme G. Piccoli" wrote:
> It might be useful to quickly get the uptime of a running
> system on xmon, without needing to grab data from memory and
> doing math on struct addresses.
> 
> For example, it'd be useful to check for how long after a crash
> a system is on xmon shell or if some test was started after the
> first test crashed (and this 2nd test crashed too into xmon).
> 
> This small patch adds the 'U' command, to accomplish this.
> 
> Suggested-by: Murilo Fossa Vicentini <muvic@linux.vnet.ibm.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/59d3391e8cf274097c42369866070c

cheers
