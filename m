Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMm7r0KmCzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 13:09:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: shuahkh@osg.samsung.com, bamvor.zhangjian@huawei.com
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/5] selftests: Fix selftests build to just build,
 not run tests
In-Reply-To: <1486630590-9410-1-git-send-email-mpe@ellerman.id.au>
References: <1486630590-9410-1-git-send-email-mpe@ellerman.id.au>
Date: Tue, 14 Feb 2017 13:09:14 +1100
Message-ID: <87shnhmsl1.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> In commit 88baa78d1f31 ("selftests: remove duplicated all and clean
> target"), the "all" target was removed from individual Makefiles and
> added to lib.mk.
>
> However the "all" target was added to lib.mk *after* the existing
> "runtests" target. This means "runtests" becomes the first (default)
> target for most of our Makefiles.
...
>
> Fix it by moving the "all" target to the start of lib.mk, making it the
> default target.
>
> Fixes: 88baa78d1f31 ("selftests: remove duplicated all and clean target")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Hi Shuah,

Can you please merge this series into linux-next?

The selftests are badly broken otherwise.

cheers
