Return-Path: <mtk.manpages@gmail.com>
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com
 [IPv6:2a00:1450:400c:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpWqF6rpFzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 01:12:57 +1000 (AEST)
Received: by mail-wm0-x22e.google.com with SMTP id l6so22492481wml.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 08:12:56 -0700 (PDT)
Subject: Re: clock_gettime.2: _COARSE clocks are not always faster...
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <87k2k67ml4.fsf@rasmusvillemoes.dk>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <5714F972.6080603@gmail.com>
Date: Mon, 18 Apr 2016 16:12:50 +0100
MIME-Version: 1.0
In-Reply-To: <87k2k67ml4.fsf@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Rasmus,

On 04/09/2016 05:50 PM, Rasmus Villemoes wrote:
> Hi Michael
> 
> The other day, I was curious how the vdso was implemented on ppc, and I
> noted that neither ppc32 or ppc64 handle the _COARSE versions of
> CLOCK_{REALTIME,MONOTONIC} in the vdso, so they fall back to an actual
> syscall. And sure enough, measuring CLOCK_MONOTONIC
> vs. CLOCK_MONOTONIC_COARSE shows that the latter has three times as much
> overhead as the former.
> 
> Whether it's worth adding a note to the man page is up to you.

I think it's useful to do so. For both *COARSE flags, I added:

[[
Requires per-architecture support, and probably also architecture support
for this flag in the vdso(7).
]]

Thanks!

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
