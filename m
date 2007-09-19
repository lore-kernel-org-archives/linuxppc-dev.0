Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC816DDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 02:37:11 +1000 (EST)
In-Reply-To: <20070919092848.GG973@shadowen.org>
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<20070919092848.GG973@shadowen.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <24129b460390d93b37ee4cf21d6a5db1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 2.6.23-rc6-mm1 -- powerpc link failure
Date: Wed, 19 Sep 2007 18:36:29 +0200
To: Andy Whitcroft <apw@shadowen.org>
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

> I am seeing this strange link error from a PowerMac G5 (powerpc):
>
>   [...]
>     KSYM    .tmp_kallsyms2.S
>     AS      .tmp_kallsyms2.o
>     LD      vmlinux.o
>   ld: dynreloc miscount for fs/built-in.o, section .opd
>   ld: can not edit opd Bad value
>   make: *** [vmlinux.o] Error 1
>
> Compiler version below.

It's an ld error, could you show us your ld version instead?  And
please try with current mainline ld, too?


Segher
