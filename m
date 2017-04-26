Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCcRq3hhLzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 20:55:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shuah Khan <shuahkh@osg.samsung.com>, shuah@kernel.org,
 bamvor.zhangjian@linaro.org, benh@kernel.crashing.org, paulus@samba.org,
 dvhart@infradead.org
Cc: viro@zeniv.linux.org.uk, emilio.lopez@collabora.co.uk, mingo@kernel.org,
 luto@kernel.org, dave.hansen@linux.intel.com, dsafonov@virtuozzo.com,
 rkrcmar@redhat.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH 2/8] selftests: lib.mk: define CLEAN macro to allow
 Makefiles to override clean
In-Reply-To: <9f62d597-e26c-e2c3-e666-975054409551@osg.samsung.com>
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
 <b39e21f8c47318d82be999aae310bdf6bcfc9bb9.1492815938.git.shuahkh@osg.samsung.com>
 <87zif9ypax.fsf@concordia.ellerman.id.au>
 <9f62d597-e26c-e2c3-e666-975054409551@osg.samsung.com>
Date: Wed, 26 Apr 2017 20:55:18 +1000
Message-ID: <87inlr1lrd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shuah Khan <shuahkh@osg.samsung.com> writes:
> On 04/21/2017 11:38 PM, Michael Ellerman wrote:
>> Shuah Khan <shuahkh@osg.samsung.com> writes:

>> This patch is a good solution to fix the warnings.
>> 
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Thanks. I plan to apply the patch with the amended changelog and your
> Ack. Please let me know if you want to see v2 with the change sent out.

I don't really mind if you send it or not.

cheers
