Return-Path: <chen.yu10@zte.com.cn>
Received: from zte.com.cn (out1.zte.com.cn [202.103.147.172])
 by ozlabs.org (Postfix) with ESMTP id 1D1C62C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 12:22:54 +1000 (EST)
In-Reply-To: <1378160357-3653-1-git-send-email-chenyu105@gmail.com>
Subject: Re: [PATCH] [RFC PATCH v1 1/1] powerpc/85xx: Wakeup kexec smp slave
 cpus in second kernel
To: wei.yang@windriver.com
Message-ID: <OF4BB75EF3.F4FE5922-ON48257BDD.0002FB7E-48257BDD.000D1017@zte.com.cn>
From: chen.yu10@zte.com.cn
Date: Thu, 5 Sep 2013 10:22:31 +0800
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: chenhui.zhao@freescale.com, wangshilong1991@gmail.com,
 liu.xiang6@zte.com.cn, lu.zhongjun@zte.com.cn, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> From: Chen Yu <chen.yu10@zte.com.cn>
>
> In current 85xx smp kexec implementation,master cpu reset slave cpus by mpic_reset_core,
> before jump to second kernel.In order to wake slave cpus up in second kernel,we debug
> this patch on p2041rdb.
>

> What problem causes that you do the modification? I am just curious as
> kexec feature always is fine on our
> P2041RDB board.:-)
>
>Wei

Well,  there might be someting wrong with my debug version.
It succeed this morning on linux 3.10.7 ,arch/powerpc/boot/corenet32_smp_defconfig,with kexec-tools-2.0.4,
The second kernel is up with 4 cpus.
I'll check my previous version.
Thank you.
