Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZGcz4DKTzDw44
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 00:37:23 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: linux-next: build failure in the powerpc allyesconfig build
Date: Thu, 08 Dec 2016 14:31:33 +0100
Message-ID: <3533648.l4A0kia4Vv@wuerfel>
In-Reply-To: <20161205162204.02c2c236@canb.auug.org.au>
References: <20161205162204.02c2c236@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, December 5, 2016 4:22:04 PM CET Stephen Rothwell wrote:
> Hi all,
> 
> After mergeing everything but Andrew's tree, today's linux-next build
> (powerpc allyesconfig) failed like this:
> 
> kallsyms failure: relative symbol value 0xc000000000000000 out of range in relative mode
> 
> I have no idea what caused this, so I have left the powerpc allyesconfig
> build broken for now.

I get this on an x86-64 randconfig build:

kallsyms failure: relative symbol value 0xffffffff81000000 out of range in relative mode

This is probably related, so it's not something powerpc specific.

	Arnd
