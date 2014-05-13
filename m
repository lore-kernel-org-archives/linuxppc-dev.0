Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 970131400D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 19:16:50 +1000 (EST)
Message-ID: <1399972601.17624.169.camel@pasglop>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 13 May 2014 19:16:41 +1000
In-Reply-To: <20140513002846.GA29753@roeck-us.net>
References: <1399874254.17624.85.camel@pasglop>
 <20140513002846.GA29753@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-05-12 at 17:28 -0700, Guenter Roeck wrote:

> After applying this patch, I get
> 
> arch/powerpc/kernel/exceptions-64s.S:269: Error: operand out of range
> (0x000000000000814c is not between 0xffffffffffff8000 and 0x0000000000007ffc)
> arch/powerpc/kernel/exceptions-64s.S:729: Error: operand out of range
> (0x000000000000814c is not between 0xffffffffffff8000 and 0x0000000000007ffc)
> 
> with powerpc:defconfig, powerpc:allmodconfig, powerpc:cell_defconfig, and
> powerpc:maple_defconfig.
> 
> This is on top of v3.15-rc5. Any idea what is going on ?
> 
> Compiler is powerpc64-poky-linux-gcc (GCC) 4.7.2 (from poky 1.4.0-1).

Interesting... works with all my test configs using 4.7.3...

I don't have my tree at hand right now, I'll check what that means
tomorrow see if I can find a workaround.

Cheers,
Ben.
