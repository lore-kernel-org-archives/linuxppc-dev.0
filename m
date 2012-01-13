Return-Path: <B29882@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE0D5B6EFF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2012 07:54:27 +1100 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Fix parse_arg build error
Date: Fri, 13 Jan 2012 20:54:13 +0000
Message-ID: <CAEsOVNexxJEHB7dsR-coJcXcone5fTsw-nPiCaz0CTq1D16v4Q@mail.gmail.com>
References: <1326431115-425-1-git-send-email-msm@freescale.com>
 <AD686389-E2D8-49C6-9443-FF3B33775469@kernel.crashing.org>
In-Reply-To: <AD686389-E2D8-49C6-9443-FF3B33775469@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 13, 2012 at 2:45 PM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
> On Jan 12, 2012, at 11:05 PM, Matthew McClintock wrote:
>
>> This fixes this build issue:
>>
>> arch/powerpc/mm/hugetlbpage.c: In function 'reserve_hugetlb_gpages':
>> arch/powerpc/mm/hugetlbpage.c:312:2: error: implicit declaration of func=
tion 'parse_args'
>> make[1]: *** [arch/powerpc/mm/hugetlbpage.o] Error 1
>>
>> Signed-off-by: Matthew McClintock <msm@freescale.com>
>> ---
>> This is for benh next tree
>>
>> arch/powerpc/mm/hugetlbpage.c | =A0 =A01 +
>> 1 files changed, 1 insertions(+), 0 deletions(-)
>
> This is fixed upstream, benh's tree is based on a older snapshot of linus=
's tree that doesn't have this fix.
>
> commit 13020be8be2d5843c3810169cdbcc51f07ff020f
> Author: Kumar Gala <galak@kernel.crashing.org>
> Date: =A0 Thu Nov 24 09:40:07 2011 +0000
>
> =A0 =A0powerpc: Fix compiliation with hugetlbfs enabled

I was starting to realize this today after I saw Ben's pull request...

-M=
