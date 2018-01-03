Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBLH25gkyzDqln
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 17:14:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: John Sperbeck <jsperbeck@google.com>
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] selftests/powerpc: Add a test of SEGV error behaviour
In-Reply-To: <CAFNjLiWrz_=epy8BE6-EVDsr6hbUO5=ykOL1gV1asc=WMOoFFQ@mail.gmail.com>
References: <20180102110324.31978-1-mpe@ellerman.id.au>
 <CAFNjLiWrz_=epy8BE6-EVDsr6hbUO5=ykOL1gV1asc=WMOoFFQ@mail.gmail.com>
Date: Wed, 03 Jan 2018 17:14:03 +1100
Message-ID: <87k1wzcvv8.fsf@concordia.ellerman.id.au>
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

John Sperbeck <jsperbeck@google.com> writes:

> On Tue, Jan 2, 2018 at 3:03 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Add a test case of the error code reported when we take a SEGV on a
>> mapped but inaccessible area. We broke this recently.
>>
>> Based on a test case from John Sperbeck <jsperbeck@google.com>.
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
...
>
> Looks good to me.
>
> Acked-by: John Sperbeck <jsperbeck@google.com>

Thanks.

cheers
