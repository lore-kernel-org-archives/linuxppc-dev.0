Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1ECC61A03EC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 09:23:27 +1000 (EST)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DEE53140173
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2014 09:23:26 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 18 Jul 2014 09:23:26 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BDA4C2BB0052
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2014 09:23:20 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6HN6VsW66584796
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2014 09:06:31 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6HNNJC2019789
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2014 09:23:20 +1000
Message-ID: <53C85AE6.7080600@au1.ibm.com>
Date: Fri, 18 Jul 2014 09:23:18 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V3 0/3] Add new PowerPC specific ELF core notes
References: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
 <53996E41.4070309@linux.vnet.ibm.com> <53C7A4FA.4030600@linux.vnet.ibm.com>
 <1405595380.25310.21.camel@pasglop>
 <CAEjGV6yK_9DS1cLQ2BH=HFi029N8rz-4Wyvwzdb_gy6PnJgbwg@mail.gmail.com>
In-Reply-To: <CAEjGV6yK_9DS1cLQ2BH=HFi029N8rz-4Wyvwzdb_gy6PnJgbwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>,
 Pedro Alves <palves@redhat.com>, oleg@redhat.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, davej@redhat.com,
 akpm@linux-foundation.org, tglx@linutronix.de,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/07/14 21:14, Michael Neuling wrote:
> 
> On Jul 17, 2014 9:11 PM, "Benjamin Herrenschmidt"
> <benh@kernel.crashing.org <mailto:benh@kernel.crashing.org>> wrote:
>>
>> > >
>> > >> Outstanding Issues
>> > >> ==================
>> > >> (1) Running DSCR register value inside a transaction does not
> seem to be saved
>> > >>     at thread.dscr when the process stops for ptrace examination.
>> > >
>> > > Hey Ben,
>> > >
>> > > Any updates on this patch series ?
>> >
>> > Ben,
>> >
>> > Any updates on this patch series ?
>>
>> I haven't had a chance to review yet, I was hoping somebody else would..
>>
>> Have you made any progress vs. the DSCR outstanding issue mentioned
>> above ?
> 
> The DSCR issue should be resolved with Sam Bobroff's recent  DSCR
> fixes.  I've not tested them though.
> 
> Actually... Sam did you review this series?
> 
> Mikey
> 

I did, and applying "powerpc: Correct DSCR during TM context switch"
corrected the DSCR value in the test program (the one in the patch notes
for this series).

(In fact, IIRC, the reason for my patch set was the bug exposed by this
one ;-)

Cheers,
Sam.
