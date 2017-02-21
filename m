Return-Path: <fweisbec@gmail.com>
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com
 [IPv6:2a00:1450:400c:c09::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSPM554P1zDqGy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 02:20:17 +1100 (AEDT)
Received: by mail-wm0-x22d.google.com with SMTP id v186so113928756wmd.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 07:20:17 -0800 (PST)
Date: Tue, 21 Feb 2017 16:20:13 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
To: abdul <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au
Subject: Re: [PowerPC] 4.10.0 fails to build on BE config
Message-ID: <20170221152011.GA2780@lerouge>
References: <c7b9f444-f7db-c098-0da9-72daeb844546@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <c7b9f444-f7db-c098-0da9-72daeb844546@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 21, 2017 at 12:55:35PM +0530, abdul wrote:
> Hi,
> 
> Today's mainline build, breaks on Power6 and Power7 (all BE config) with
> these build errors
> 
> arch/powerpc/kernel/time.c: In function ‘running_clock’:
> arch/powerpc/kernel/time.c:712:2: error: implicit declaration of function
> ‘cputime_to_nsecs’ [-Werror=implicit-function-declaration]
> return local_clock() -
> cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIME_STEAL]);
> ^
> cc1: some warnings being treated as errors
> make[1]: *** [arch/powerpc/kernel/time.o] Error 1

Thanks for reporting this!
I just sent a fix.
