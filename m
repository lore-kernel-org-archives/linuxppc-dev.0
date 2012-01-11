Return-Path: <linus971@gmail.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
 [74.125.82.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 45B0DB6EEA
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2012 17:08:41 +1100 (EST)
Received: by wera13 with SMTP id a13so299069wer.15
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jan 2012 22:08:37 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1326243935.23910.85.camel@pasglop>
References: <1326243935.23910.85.camel@pasglop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 10 Jan 2012 22:08:14 -0800
Message-ID: <CA+55aFycfYKFagVgckrEm3dAFHNZEvm0Hkw0UbH+XfKQu8Cvzg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Default y for pseries
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Shaohua Li <shaohua.li@intel.com>,
 linux-pm@vger.kernel.org, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 10, 2012 at 5:05 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Linus, do you want to just pick that up or should I put it into powerpc.git
> and ask you to pull ? I will have 2 or 3 other fixes there later today,
> but I wanted to make sure you were ok with the approach with this
> specific one.

It doesn't seem to be all that different from the "default y if ACPI"
case, so I guess it works ok.

That said, I wonder if the right approach wouldn't be

   default y if SUPPORT_CPU_IDLE

or something along those lines. And then both ACPI and PPC_PSERIES
could just select that instead. Because I do hate having random
board-level knowledge in something like this. I dunno.

                   Linus
