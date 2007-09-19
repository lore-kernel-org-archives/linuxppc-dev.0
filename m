Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6F29DDF14
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 02:53:25 +1000 (EST)
Date: Wed, 19 Sep 2007 17:52:50 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 2.6.23-rc6-mm1 -- powerpc link failure
Message-ID: <20070919165250.GD2519@shadowen.org>
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<20070919092848.GG973@shadowen.org>
	<24129b460390d93b37ee4cf21d6a5db1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <24129b460390d93b37ee4cf21d6a5db1@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2007 at 06:36:29PM +0200, Segher Boessenkool wrote:
> >I am seeing this strange link error from a PowerMac G5 (powerpc):
> >
> >  [...]
> >    KSYM    .tmp_kallsyms2.S
> >    AS      .tmp_kallsyms2.o
> >    LD      vmlinux.o
> >  ld: dynreloc miscount for fs/built-in.o, section .opd
> >  ld: can not edit opd Bad value
> >  make: *** [vmlinux.o] Error 1
> >
> >Compiler version below.
> 
> It's an ld error, could you show us your ld version instead?  And
> please try with current mainline ld, too?

root@elm3b19:~# ld -v
GNU ld version 2.16.91 20060118 Debian GNU/Linux

Getting the compiler suite changed on here is going to be a lot
tricker.  One of the reasons we keep it back there is those versions
are supposed to be supported and we want to test those combinations.

-apw
