Return-Path: <carlos@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27E881A17E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 04:45:40 +1100 (AEDT)
Subject: Re: [PATCH] Add hwcap2 bits for POWER9
To: munroesj@linux.vnet.ibm.com
References: <568C272D.6000705@linux.vnet.ibm.com>
 <87egdsi4om.fsf@totoro.br.ibm.com> <1452267366.5201.12.camel@vnet.ibm.com>
 <568FE3D0.7080008@linaro.org> <87wprgdu3u.fsf@totoro.br.ibm.com>
 <5693C861.9030308@redhat.com> <87bn8revra.fsf@totoro.br.ibm.com>
 <56941532.9030800@redhat.com> <1452616757.29488.10.camel@oc7878010663>
Cc: Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 libc-alpha@sourceware.org, linuxppc-dev@lists.ozlabs.org
From: "Carlos O'Donell" <carlos@redhat.com>
Message-ID: <56953BC1.7050705@redhat.com>
Date: Tue, 12 Jan 2016 12:45:37 -0500
MIME-Version: 1.0
In-Reply-To: <1452616757.29488.10.camel@oc7878010663>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/12/2016 11:39 AM, Steven Munroe wrote:
>> That's the rule. There are no other discussions to be had.
>>
> Well is was posted to to powerpc next:
> https://git.kernel.org/powerpc/c/e708c24cd01ce80b1609d8bacc
> 
> We have agreement between the kernel and GLIBC (and the ABI). 
> 
> The issue is just coordination across communities and individuals that
> may not being paying attention to other communities dead lines.
> 
> Have you ever tried to push a string, up hill. That is open source
> development in nutshell. ;)

I know exactly what this is like.

> So it is in flight and glibc is soft/slush freeze. I would hate to
> revert this one day just to add it back to the next. Especially if those
> days straddle the hard freeze ...
> 
> So can we let this ride a day or too?

Sure. I'm not an unreasonable person.

My goal as a glibc steward is to remind IBM that our best practice is that
we *wait* until it goes into mainline before committing to glibc master.

There really isn't any reason to check this in to glibc master right now.
It could wait.

Adhemerval as a release manager is also not an unreasonable person.
I have already discussed with Tulio that he should have just waited to
commit these changes, but gotten an exception from Adhemerval to checkin
the fairly low-risk patches late in the freeze. That's exactly the purpose
of a release managers job, to grant you exceptions as we approach release,
particularly when schedules don't quite line up.

Cheers,
Carlos.
