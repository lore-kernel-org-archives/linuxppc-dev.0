Return-Path: <shuahkh@osg.samsung.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN7640wLkzDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 03:24:12 +1100 (AEDT)
Received: from osg.samsung.com
 (ec2-52-27-115-49.us-west-2.compute.amazonaws.com [52.27.115.49])
 by ozlabs.org (Postfix) with ESMTP id 3vN7635Jr1z9s1h
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Feb 2017 03:24:10 +1100 (AEDT)
Subject: Re: [PATCH 1/5] selftests: Fix selftests build to just build, not run
 tests
To: Michael Ellerman <mpe@ellerman.id.au>, bamvor.zhangjian@huawei.com
References: <1486630590-9410-1-git-send-email-mpe@ellerman.id.au>
 <87shnhmsl1.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <c539ac89-37f8-ebee-49ca-9d80fc1ff1f1@osg.samsung.com>
Date: Tue, 14 Feb 2017 09:14:24 -0700
MIME-Version: 1.0
In-Reply-To: <87shnhmsl1.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/13/2017 07:09 PM, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
>> In commit 88baa78d1f31 ("selftests: remove duplicated all and clean
>> target"), the "all" target was removed from individual Makefiles and
>> added to lib.mk.
>>
>> However the "all" target was added to lib.mk *after* the existing
>> "runtests" target. This means "runtests" becomes the first (default)
>> target for most of our Makefiles.
> ...
>>
>> Fix it by moving the "all" target to the start of lib.mk, making it the
>> default target.
>>
>> Fixes: 88baa78d1f31 ("selftests: remove duplicated all and clean target")
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Hi Shuah,
> 
> Can you please merge this series into linux-next?
> 
> The selftests are badly broken otherwise.
> 
> cheers
> 

Hi Michael,

Thanks. All 5 patches are now in linux-kselftest next with Tested-by
tag from Bamvor for 1,2,3.

thank you both,
-- Shuah
