Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-la0-x229.google.com (mail-la0-x229.google.com
 [IPv6:2a00:1450:4010:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 145482C0448
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 01:37:19 +1000 (EST)
Received: by mail-la0-f41.google.com with SMTP id fn20so9315137lab.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2013 08:37:15 -0700 (PDT)
Message-ID: <51C70F82.4030101@cogentembedded.com>
Date: Sun, 23 Jun 2013 19:08:50 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/45] CPU hotplug: Expose the new debug config option
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
 <20130623133928.19094.8259.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130623133928.19094.8259.stgit@srivatsabhat.in.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, "Paul E. McKenney" <paul.mckenney@linaro.org>,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 Catalin Marinas <catalin.marinas@arm.com>, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 Akinobu Mita <akinobu.mita@gmail.com>, rostedt@goodmis.org,
 namhyung@kernel.org, tglx@linutronix.de, laijs@cn.fujitsu.com,
 zhong@linux.vnet.ibm.com, netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu,
 tj@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 23-06-2013 17:39, Srivatsa S. Bhat wrote:

> Now that we have all the pieces of the CPU hotplug debug infrastructure
> in place, expose the feature by growing a new Kconfig option,
> CONFIG_DEBUG_HOTPLUG_CPU.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Paul E. McKenney" <paul.mckenney@linaro.org>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Michel Lespinasse <walken@google.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---

>   lib/Kconfig.debug |    9 +++++++++
>   1 file changed, 9 insertions(+)

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 566cf2b..6be1e72 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -512,6 +512,15 @@ config DEBUG_PREEMPT
>   	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
>   	  will detect preemption count underflows.
>
> +config DEBUG_HOTPLUG_CPU
> +	bool "Debug CPU hotplug"
> +	depends on HOTPLUG_CPU
> +	default n

     It's the default default, no need to specify it.

WBR, Sergei
