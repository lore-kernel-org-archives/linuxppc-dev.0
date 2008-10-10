Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ABF00DDF00
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 15:52:15 +1100 (EST)
Subject: Re: [PATCH 2/2] Move memory size print into common show_cpuinfo
	for 32-bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <1222293230-22725-1-git-send-email-becky.bruce@freescale.com>
References: <1222293230-22725-1-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 15:32:20 +1100
Message-Id: <1223613140.8157.150.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-09-24 at 16:53 -0500, Becky Bruce wrote:
> Most of the platforms were printing the size of the memory
> in their show_cpuinfo implementations. This moves that to
> the common show_cpuinfo, so that all 32-bit platforms will
> now print the size of memory.  I also update the code
> to deal with the fact that total_memory is now a phys_addr_t.

Doesn't apply anymore, care to rebase ?

Cheers,
Ben.
