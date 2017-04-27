Return-Path: <shuahkh@osg.samsung.com>
Received: from osg.samsung.com
 (ec2-52-27-115-49.us-west-2.compute.amazonaws.com [52.27.115.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wDWCH2Q0FzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 08:02:34 +1000 (AEST)
Subject: Re: [PATCH 0/8] Fix clean target warnings
To: shuah@kernel.org, bamvor.zhangjian@linaro.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, dvhart@infradead.org
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
Cc: viro@zeniv.linux.org.uk, emilio.lopez@collabora.co.uk, mingo@kernel.org,
 luto@kernel.org, dave.hansen@linux.intel.com, dsafonov@virtuozzo.com,
 rkrcmar@redhat.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Shuah Khan <shuahkh@osg.samsung.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <831a9104-b186-bae7-be87-5f4adb664dcd@osg.samsung.com>
Date: Thu, 27 Apr 2017 16:02:29 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1492815938.git.shuahkh@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/21/2017 05:14 PM, Shuah Khan wrote:
> This patch series consists of changes to lib.mk to allow overriding
> common clean target from Makefiles. This fixes warnings when clean
> overriding and ignoring warnings. Also fixes splice clean target
> removing a script that runs the test from its clean target.
> 
> Shuah Khan (8):
>   selftests: splice: fix clean target to not remove
>     default_file_splice_read.sh
>   selftests: lib.mk: define CLEAN macro to allow Makefiles to override
>     clean

Applied with amended change log and Michael's ack to linux-kselftest next

>   selftests: futex: override clean in lib.mk to fix warnings
>   selftests: gpio: override clean in lib.mk to fix warnings
>   selftests: powerpc: override clean in lib.mk to fix warnings

Applied all of the above to linux-kseltftest next

>   selftests: splice: override clean in lib.mk to fix warnings
>   selftests: sync: override clean in lib.mk to fix warnings
>   selftests: x86: override clean in lib.mk to fix warnings

Applied v2s addressing Michael's comments to linux-kselftest next
x86 fix also addresses not being able to build ldt_gdt

make -C tools/testing/selftests/x86 ldt_gdt


thanks,
-- Shuah
