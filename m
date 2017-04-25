Return-Path: <shuahkh@osg.samsung.com>
Received: from osg.samsung.com
 (ec2-52-27-115-49.us-west-2.compute.amazonaws.com [52.27.115.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wC44k2ccfzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 23:36:53 +1000 (AEST)
Subject: Re: [PATCH 2/8] selftests: lib.mk: define CLEAN macro to allow
 Makefiles to override clean
To: Michael Ellerman <mpe@ellerman.id.au>, shuah@kernel.org,
 bamvor.zhangjian@linaro.org, benh@kernel.crashing.org, paulus@samba.org,
 dvhart@infradead.org
References: <cover.1492815938.git.shuahkh@osg.samsung.com>
 <b39e21f8c47318d82be999aae310bdf6bcfc9bb9.1492815938.git.shuahkh@osg.samsung.com>
 <87zif9ypax.fsf@concordia.ellerman.id.au>
Cc: viro@zeniv.linux.org.uk, emilio.lopez@collabora.co.uk, mingo@kernel.org,
 luto@kernel.org, dave.hansen@linux.intel.com, dsafonov@virtuozzo.com,
 rkrcmar@redhat.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Shuah Khan <shuahkh@osg.samsung.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <9f62d597-e26c-e2c3-e666-975054409551@osg.samsung.com>
Date: Tue, 25 Apr 2017 07:36:40 -0600
MIME-Version: 1.0
In-Reply-To: <87zif9ypax.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/21/2017 11:38 PM, Michael Ellerman wrote:
> Shuah Khan <shuahkh@osg.samsung.com> writes:
> 
>> Define CLEAN macro to allow Makefiles to override common clean target
>> in lib.mk. This will help fix the following failures:
>>
>> warning: overriding recipe for target 'clean'
>> ../lib.mk:55: warning: ignoring old recipe for target 'clean'
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> 
> Should probably have:
> 
> Fixes: 88baa78d1f31 ("selftests: remove duplicated all and clean target")

Amended the change log to add the above.

> 
> 
> In hindsight I'm not sure moving the clean target into lib.mk was
> the best idea, but anyway it's a bit late to change our mind on that.

Yeah. Moving clean target to lib.mk ended up to be problematic. However,
there are some advantages as well. It will simplify some Makefiles. One
thing that was missed was that not finding the Makefiles that require
overrides. Anyway live and learn.

> 
> This patch is a good solution to fix the warnings.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 

Thanks. I plan to apply the patch with the amended changelog and your
Ack. Please let me know if you want to see v2 with the change sent out.

thanks,
-- Shuah
