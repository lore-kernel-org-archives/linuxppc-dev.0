Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BF62DDE43
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 05:10:05 +1000 (EST)
In-Reply-To: <200708011002.30962.m.kozlowski@tuxland.pl>
References: <20070731230932.a9459617.akpm@linux-foundation.org>
	<200708011002.30962.m.kozlowski@tuxland.pl>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <76e360562cd5b50bcd991026e5bead55@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 2.6.23-rc1-mm2
Date: Mon, 6 Aug 2007 21:08:56 +0200
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Second issue as reported earilier allmodconfig fails to build on imac 
> g3.
>
>   CC      arch/powerpc/kernel/lparmap.s
>   AS      arch/powerpc/kernel/head_64.o
> lparmap.c: Assembler messages:
> lparmap.c:84: Error: file number 1 already allocated
> make[1]: *** [arch/powerpc/kernel/head_64.o] Blad 1
> make: *** [arch/powerpc/kernel] Blad 2

Please send me the full output of:

gcc --version    (or whatever your gcc is called)
ld --version
ld --help        (I know no better way to get the supported binutils
                   targets, and the default target)

and the lparmap.s file.  You might want to skip sending it
to the lists, it will be a bit big (and off-topic on most
of those lists, anyway).


Segher
