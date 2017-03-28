Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsbLt1qWSzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 14:03:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/5] powerpc/smp: use cpu_to_chip_id() to find siblings
In-Reply-To: <CAOSf1CHwODMGc=G=OT21TrSit_G4ypd5sgCrCZOxWAGy3GtEww@mail.gmail.com>
References: <20170302004920.21948-1-oohall@gmail.com>
 <877f3qlrep.fsf@concordia.ellerman.id.au>
 <CAOSf1CHwODMGc=G=OT21TrSit_G4ypd5sgCrCZOxWAGy3GtEww@mail.gmail.com>
Date: Tue, 28 Mar 2017 14:03:33 +1100
Message-ID: <87bmsmayre.fsf@concordia.ellerman.id.au>
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

Oliver O'Halloran <oohall@gmail.com> writes:
> On Wed, Mar 15, 2017 at 10:18 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Oliver O'Halloran <oohall@gmail.com> writes:
>>> +     /* threads that share a chip-id are considered siblings (same die) */
>>
>> Also "Threads" :)
>
> The cpus masks are all built in terms of threads, so this is
> technically correct even if it sounds stupid. Maybe "logical cpus"
> would be better?

No I meant you need a capital "T" !

cheers
