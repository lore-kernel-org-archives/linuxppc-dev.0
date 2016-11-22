Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNF886NkdzDvtQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 16:56:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 4/7] powerpc/64: tool to check head sections location
 sanity
In-Reply-To: <20161122155447.61198020@roar.ozlabs.ibm.com>
References: <20161019031600.17933-1-npiggin@gmail.com>
 <20161019031600.17933-5-npiggin@gmail.com>
 <8760npimtd.fsf@concordia.ellerman.id.au>
 <20161122155447.61198020@roar.ozlabs.ibm.com>
Date: Tue, 22 Nov 2016 16:56:04 +1100
Message-ID: <871sy4vz0r.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:
> On Tue, 15 Nov 2016 11:55:26 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> > diff --git a/arch/powerpc/tools/head_check.sh b/arch/powerpc/tools/head_check.sh
>> > new file mode 100755
>> > index 0000000..9635fe7
>> > --- /dev/null
>> > +++ b/arch/powerpc/tools/head_check.sh
>> > @@ -0,0 +1,69 @@
>> > +#!/bin/sh  
>> 
>> We run this explicitly via $(CONFIG_SHELL), so having a shebang here is
>> redundant and also a little confusing. I added "-x" here, to turn on
>> tracing, but it doesn't take effect, so I think better to just drop the
>> line. If anyone wants to run it manually they can just pass it to sh.
>
> Okay. How about relocs_check.sh? I just started by copying that.

Yeah may as well fix it too. 

>> # Turn this on if you want more debug output:
>> # set -x
>
> Can do, same question applies for relocs_check.sh

Yep, save the next person who's debugging it the time.

cheers
