Return-Path: <oohall@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPSf95DvjzDw3t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 16:37:53 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id n34so2015208qtb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 21:37:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161123143834.GB6099@gate.crashing.org>
References: <20161123130840.1877-1-npiggin@gmail.com>
 <20161123143834.GB6099@gate.crashing.org>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 24 Nov 2016 16:37:50 +1100
Message-ID: <CAOSf1CEJwdCCPVcksOBUSut_fPbr6WizacRrFRgMAJAeWoCqRw@mail.gmail.com>
Subject: Re: [RFC][PATCH] powerpc/64be: use ELFv2 ABI for big endian kernels
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alan Modra <amodra@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 24, 2016 at 1:38 AM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> On Thu, Nov 24, 2016 at 12:08:40AM +1100, Nicholas Piggin wrote:
>> Question, are there any fundamental reasons we shouldn't use the ELFv2
>> ABI to build big endian kernels if the compiler supports it?
>
> No one uses ELFv2 for BE in production, and it isn't thoroughly tested
> at all, not even regularly tested.  "Not supported", as far as GCC is
> concerned (or any of the distros AFAIK).

Is this actually unsupported by gcc? The ppc64 musl libc port is ABI
v2 only so they use it on BE too. Buildroot forces ABI v2 to be used
for all of userspace when musl is selected as the libc for this reason
so it's not completely used in the wild. It's still pretty niche
though...
