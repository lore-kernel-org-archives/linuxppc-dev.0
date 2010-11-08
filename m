Return-Path: <jacmet@gmail.com>
Received: from mail-ww0-f52.google.com (mail-ww0-f52.google.com [74.125.82.52])
	by ozlabs.org (Postfix) with ESMTP id 0E183B70FB
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Nov 2010 18:23:45 +1100 (EST)
Received: by wwa36 with SMTP id 36so5312037wwa.21
	for <linuxppc-dev@ozlabs.org>; Sun, 07 Nov 2010 23:23:43 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Consolidate obj-y assignments
References: <0429b4b15a3c65fdae92f92cce656b4859dca05e.1289190214.git.michael@ellerman.id.au>
Date: Mon, 08 Nov 2010 08:23:39 +0100
In-Reply-To: <0429b4b15a3c65fdae92f92cce656b4859dca05e.1289190214.git.michael@ellerman.id.au>
	(Michael Ellerman's message of "Mon, 8 Nov 2010 15:24:10 +1100 (EST)")
Message-ID: <87y694z3b8.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Michael" == Michael Ellerman <michael@ellerman.id.au> writes:

 Michael> No need to have three of them.
 Michael> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
 Michael> ---
 Michael>  arch/powerpc/kernel/Makefile |    9 ++++-----
 Michael>  1 files changed, 4 insertions(+), 5 deletions(-)

 Michael> -		        signal.o sysfs.o cacheinfo.o
 Michael> -obj-y		+= vdso32/
 Michael> +			signal.o sysfs.o cacheinfo.o time.o \
 Michael> +			time.o prom.o traps.o setup-common.o \

You have time.o twice.

-- 
Bye, Peter Korsgaard
