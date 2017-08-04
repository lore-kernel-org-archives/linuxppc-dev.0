Return-Path: <matthew.brown.dev@gmail.com>
Received: from mail-qk0-x236.google.com (mail-qk0-x236.google.com
 [IPv6:2607:f8b0:400d:c09::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNqPb6K4GzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 11:40:35 +1000 (AEST)
Received: by mail-qk0-x236.google.com with SMTP id z18so1900517qka.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Aug 2017 18:40:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87379astus.fsf@linkitivity.dja.id.au>
References: <20170428055809.2675-1-matthew.brown.dev@gmail.com>
 <20170428055809.2675-2-matthew.brown.dev@gmail.com>
 <87379astus.fsf@linkitivity.dja.id.au>
From: Matt Brown <matthew.brown.dev@gmail.com>
Date: Fri, 4 Aug 2017 11:40:32 +1000
Message-ID: <CAPoR37Zefef-o4sXfUtTd-VsQK87Y+2dQNrsY=fT2s4Sp08Xdg@mail.gmail.com>
Subject: Re: [v5 2/2] raid6/altivec: Add vpermxor implementation for raid6 Q
 syndrome
To: Daniel Axtens <dja@axtens.net>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 2, 2017 at 10:20 AM, Daniel Axtens <dja@axtens.net> wrote:
> Oh, one final thing - I just realised there's a .gitignore file in
> lib/raid6/.gitignore that needs to be updated to include the vpermxor
> generated files. That should be part of this patch.
>

Oh, I managed to miss that!
I'll add that and fix up that comment spacing.

Thanks,
Matt



> Regards,
> Daniel
