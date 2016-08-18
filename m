Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFR4v59FlzDr7w
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 22:59:27 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id cf3so1852000pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 05:59:27 -0700 (PDT)
Date: Thu, 18 Aug 2016 22:59:09 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 aneesh.kumar@linux.vnet.ibm.com, ego@linux.vnet.ibm.com
Subject: Re: [PowerPC] today's main line failed to build on PowerPC
Message-ID: <20160818125909.GA6154@350D>
Reply-To: bsingharora@gmail.com
References: <fcd669dc-7ad2-aeff-fb66-14c06c4f9a7d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fcd669dc-7ad2-aeff-fb66-14c06c4f9a7d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 18, 2016 at 11:50:28AM +0530, Abdul Haleem wrote:
> Hi,
> 
> The main line stable 4.8.0-rc2 failed to build on PowerPC with following
> build errors. config : pseries_le_defconfig Machine Type : PowerPC Bare
> Metal
> 
> 09:34:22 00:04:59 INFO | make -j 160  vmlinux
> 09:34:24 00:05:01 ERROR| [stderr] arch/powerpc/mm/hash_low_32.S: Assembler messages:
> 09:34:24 00:05:01 ERROR| [stderr] arch/powerpc/mm/hash_low_32.S:353: Error: missing operand
> 09:34:24 00:05:01 ERROR| [stderr] arch/powerpc/mm/hash_low_32.S:612: Error: missing operand
> 09:34:24 00:05:01 ERROR| [stderr] arch/powerpc/mm/hash_low_32.S:670: Error: missing operand
> 09:34:24 00:05:01 ERROR| [stderr] make[1]: *** [arch/powerpc/mm/hash_low_32.o] Error 1
> 09:34:24 00:05:01 ERROR| [stderr] make[1]: *** Waiting for unfinished jobs....
> 09:34:25 00:05:02 ERROR| [stderr] arch/powerpc/kernel/head_32.S: Assembler messages:
> 09:34:25 00:05:02 ERROR| [stderr] arch/powerpc/kernel/head_32.S:1113: Error: missing operand
> 09:34:25 00:05:02 ERROR| [stderr] make[1]: *** [arch/powerpc/kernel/head_32.o] Error 1
> 09:34:25 00:05:02 ERROR| [stderr] make[1]: *** Waiting for unfinished jobs....
> 09:34:27 00:05:04 ERROR| [stderr] make: *** [arch/powerpc/mm] Error 2
> 09:34:27 00:05:04 ERROR| [stderr] make: *** Waiting for unfinished jobs....
> 09:34:42 00:05:19 ERROR| [stderr] make: *** [arch/powerpc/kernel] Error 2
>

Sounds like the assembler could not build the 32 bit assembly files. Has
the build succeeded with the same compiler/toolchain and options before?
 
> Regard's
> Abdul
> 
