Return-Path: <arnd@arndb.de>
Received: from mout-bounce.kundenserver.de (mout-bounce.kundenserver.de
	[212.227.17.1]) by ozlabs.org (Postfix) with ESMTP id C10CEDDEF8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 06:10:55 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/cell: fix some types
Date: Wed, 7 Jan 2009 20:10:42 +0100
References: <20090107110344.5fbada03.sfr@canb.auug.org.au>
In-Reply-To: <20090107110344.5fbada03.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901072010.43117.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Molnar <mingo@elte.hu>,
	Ingo@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 January 2009, Stephen Rothwell wrote:
> From: Ingo Molnar <mingo@elte.hu>
> 
> in/out_be64() work on u64s.
> 
> The first parameter to ppc_md.ioremap is a phys_addr_t.
> 
> [Split out from a large patch - sfr]
> [A couple of updates - sfr]
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>
