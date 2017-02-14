Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNDdd6LYQzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 07:33:25 +1100 (AEDT)
Date: Wed, 15 Feb 2017 07:33:17 +1100
In-Reply-To: <c539ac89-37f8-ebee-49ca-9d80fc1ff1f1@osg.samsung.com>
References: <1486630590-9410-1-git-send-email-mpe@ellerman.id.au>
 <87shnhmsl1.fsf@concordia.ellerman.id.au>
 <c539ac89-37f8-ebee-49ca-9d80fc1ff1f1@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH 1/5] selftests: Fix selftests build to just build,
 not run tests
To: Shuah Khan <shuahkh@osg.samsung.com>, Michael Ellerman <mpe@ellerman.id.au>,
 bamvor.zhangjian@huawei.com
CC: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
From: Michael Ellerman <michael@ellerman.id.au>
Message-ID: <7B55CA75-EA92-4F33-81CD-26D4A19EBE70@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 15 February 2017 03:14:24 GMT+11:00, Shuah Khan <shuahkh@osg=2Esamsung=
=2Ecom> wrote:
>On 02/13/2017 07:09 PM, Michael Ellerman wrote:
>> Michael Ellerman <mpe@ellerman=2Eid=2Eau> writes:
>>=20
>>> In commit 88baa78d1f31 ("selftests: remove duplicated all and clean
>>> target"), the "all" target was removed from individual Makefiles and
>>> added to lib=2Emk=2E
>>>
>>> However the "all" target was added to lib=2Emk *after* the existing
>>> "runtests" target=2E This means "runtests" becomes the first (default)
>>> target for most of our Makefiles=2E
>> =2E=2E=2E
>>>
>>> Fix it by moving the "all" target to the start of lib=2Emk, making it
>the
>>> default target=2E
>>>
>>> Fixes: 88baa78d1f31 ("selftests: remove duplicated all and clean
>target")
>>> Signed-off-by: Michael Ellerman <mpe@ellerman=2Eid=2Eau>
>>=20
>> Hi Shuah,
>>=20
>> Can you please merge this series into linux-next?
>>=20
>> The selftests are badly broken otherwise=2E
>>=20
>> cheers
>>=20
>
>Hi Michael,
>
>Thanks=2E All 5 patches are now in linux-kselftest next with Tested-by
>tag from Bamvor for 1,2,3=2E

Thanks!
--=20
Sent from my Android phone with K-9 Mail=2E Please excuse my brevity=2E
