Return-Path: <valentinrothberg@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3g5F03MhzDv07
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 17:26:09 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id d128so2792437wmf.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 23:26:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <878ttby7vh.fsf@concordia.ellerman.id.au>
References: <20161005055726.5614-1-valentinrothberg@gmail.com>
 <1475708074.735.2.camel@gmail.com> <878ttby7vh.fsf@concordia.ellerman.id.au>
From: Valentin Rothberg <valentinrothberg@gmail.com>
Date: Wed, 26 Oct 2016 08:25:35 +0200
Message-ID: <CAD3Xx4KqNbpjognpyC=NVqFQ0wH+uc+vQU23PP99625ufCLZnA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: process.c: fix Kconfig typo
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Cyril Bur <cyrilbur@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 26, 2016 at 7:52 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Cyril Bur <cyrilbur@gmail.com> writes:
>
>> On Wed, 2016-10-05 at 07:57 +0200, Valentin Rothberg wrote:
>>> s/ALIVEC/ALTIVEC/
>>>
>>
>> Oops, nice catch
>>
>>> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
>>
>> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>
>
> How did we not notice? Sounds like we need a new selftest.
>
> Looks like this should have:
>
> Fixes: dc16b553c949 ("powerpc: Always restore FPU/VEC/VSX if hardware transactional memory in use")
>
>
> And I guess I need to start running checkkconfigsymbols.py on every
> commit.

Happy to find a new user :-)  You can also run the script on a range
of commits via '--diff commitA..commitB', which can safe some time.

Best regards,
 Valentin

> cheers
