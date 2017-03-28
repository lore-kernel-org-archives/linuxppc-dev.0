Return-Path: <oohall@gmail.com>
Received: from mail-qt0-x22a.google.com (mail-qt0-x22a.google.com
 [IPv6:2607:f8b0:400d:c0d::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsbnT1W5wzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 14:23:09 +1100 (AEDT)
Received: by mail-qt0-x22a.google.com with SMTP id x35so54206025qtc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 20:23:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87bmsmayre.fsf@concordia.ellerman.id.au>
References: <20170302004920.21948-1-oohall@gmail.com>
 <877f3qlrep.fsf@concordia.ellerman.id.au>
 <CAOSf1CHwODMGc=G=OT21TrSit_G4ypd5sgCrCZOxWAGy3GtEww@mail.gmail.com>
 <87bmsmayre.fsf@concordia.ellerman.id.au>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Tue, 28 Mar 2017 14:23:06 +1100
Message-ID: <CAOSf1CEHO+idHS5NQSZAjMtg9nO4B7DbmstyAs859_PO1M_kOA@mail.gmail.com>
Subject: Re: [PATCH 1/5] powerpc/smp: use cpu_to_chip_id() to find siblings
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 28, 2017 at 2:03 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Oliver O'Halloran <oohall@gmail.com> writes:
>> On Wed, Mar 15, 2017 at 10:18 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> Oliver O'Halloran <oohall@gmail.com> writes:
>>>> +     /* threads that share a chip-id are considered siblings (same die) */
>>>
>>> Also "Threads" :)
>>
>> The cpus masks are all built in terms of threads, so this is
>> technically correct even if it sounds stupid. Maybe "logical cpus"
>> would be better?
>
> No I meant you need a capital "T" !

capital letters are against my religion.

>
> cheers
