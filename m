Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WY136Fw0zDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 22:17:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/msi: Remove VLA usage
In-Reply-To: <CAGXu5jKV-YAQZtN2heFdmiD9EOZ-AqrBc-NjC8fRYLSafovuyQ@mail.gmail.com>
References: <20180629185254.GA37557@beast>
 <CAGXu5jKV-YAQZtN2heFdmiD9EOZ-AqrBc-NjC8fRYLSafovuyQ@mail.gmail.com>
Date: Thu, 19 Jul 2018 22:17:10 +1000
Message-ID: <8736wfctdl.fsf@concordia.ellerman.id.au>
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

Kees Cook <keescook@chromium.org> writes:

> On Fri, Jun 29, 2018 at 11:52 AM, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> switches from an unchanging variable to a constant expression to eliminate
>> the VLA generation.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Friendly ping! Michael, can you take this?

Yep, sorry. I actually applied it weeks ago but hadn't pushed.

cheers
