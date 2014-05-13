Return-Path: <groeck7@gmail.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AB6DA140087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 03:18:04 +1000 (EST)
Received: by mail-pa0-f44.google.com with SMTP id ld10so524830pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 10:18:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 13 May 2014 10:17:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
Message-ID: <20140513171749.GA9440@roeck-us.net>
References: <1399874254.17624.85.camel@pasglop>
 <20140513002846.GA29753@roeck-us.net>
 <1399972601.17624.169.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399972601.17624.169.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 13, 2014 at 07:16:41PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2014-05-12 at 17:28 -0700, Guenter Roeck wrote:
> 
> > After applying this patch, I get
> > 
> > arch/powerpc/kernel/exceptions-64s.S:269: Error: operand out of range
> > (0x000000000000814c is not between 0xffffffffffff8000 and 0x0000000000007ffc)
> > arch/powerpc/kernel/exceptions-64s.S:729: Error: operand out of range
> > (0x000000000000814c is not between 0xffffffffffff8000 and 0x0000000000007ffc)
> > 
> > with powerpc:defconfig, powerpc:allmodconfig, powerpc:cell_defconfig, and
> > powerpc:maple_defconfig.
> > 
> > This is on top of v3.15-rc5. Any idea what is going on ?
> > 
> > Compiler is powerpc64-poky-linux-gcc (GCC) 4.7.2 (from poky 1.4.0-1).
> 
> Interesting... works with all my test configs using 4.7.3...
> 
> I don't have my tree at hand right now, I'll check what that means
> tomorrow see if I can find a workaround.
> 
It works for me with gcc 4.8.2 (build from yocto 1.6.0).

Is asking people to use gcc 4.7.3 or later acceptable ?

Guenter
