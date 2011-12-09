Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id CE9F91007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 12:46:43 +1100 (EST)
Received: by vcbfl15 with SMTP id fl15so2034851vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Dec 2011 17:46:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111209123811.12cf28971f21a309976f31bb@canb.auug.org.au>
References: <20111209123811.12cf28971f21a309976f31bb@canb.auug.org.au>
Date: Thu, 8 Dec 2011 20:46:39 -0500
Message-ID: <CA+5PVA5vVC=e24imM0QxbT10kBAF4v=kwheKs7cOHKKcC+if=A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the 4xx tree with the powerpc tree
From: Josh Boyer <jwboyer@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Tanmay Inamdar <tinamdar@apm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 8, 2011 at 8:38 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Josh,
>
> Today's linux-next merge of the 4xx tree got a conflict in
> arch/powerpc/platforms/40x/ppc40x_simple.c between commit 11eab297f57b
> ("powerpc: Add support for OpenBlockS 600") from the powerpc tree and
> commit d5b9ee7b514e ("powerpc/40x: Add APM8018X SOC support") from the
> 4xx tree.

I blame BenH.  I sent him a pull request with d5b9ee7b514e in it
before he went and updated his tree.  Still not pulled afaik.  Guess
I'll be rebasing my next branch tomorrow to pick up a series from Tony
Breeds, unless Ben handles the outstanding pull before I wake up :).

> I fixed it up (see below) and can carry the fix as necessary.

Looks correct to me.  Hopefully you won't have to carry it long.
>
> [Josh: I have changed you contact address to the above]

Thank you.

josh
