Return-Path: <richard@nod.at>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B35F1A0F76
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 16:35:22 +1000 (AEST)
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2C80F1402B1
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 16:35:20 +1000 (AEST)
Message-ID: <55792A92.2050707@nod.at>
Date: Thu, 11 Jun 2015 08:28:34 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org,
 Brian Norris <computersforpeace@gmail.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH V3] drivers/mtd: add powernv flash MTD abstraction driver
References: <1433219169-5115-1-git-send-email-cyrilbur@gmail.com>	
 <1433479201.3379.10.camel@cyril>	
 <CAFLxGvxM1V8EMmZotqhSUG-q0cy+NpufeksChjJrD0qSJCSB0g@mail.gmail.com>
 <1434001398.28304.3.camel@ellerman.id.au>
In-Reply-To: <1434001398.28304.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 11.06.2015 um 07:43 schrieb Michael Ellerman:
> On Fri, 2015-06-05 at 10:16 +0200, Richard Weinberger wrote:
>> On Fri, Jun 5, 2015 at 6:40 AM, Cyril Bur <cyrilbur@gmail.com> wrote:
>>> On Tue, 2015-06-02 at 14:26 +1000, Cyril Bur wrote:
>>>> Powerpc powernv platforms allow access to certain system flash devices
>>>> through a firmwarwe interface. This change adds an mtd driver for these
>>>> flash devices.
>>>>
>>>> Minor updates from Jeremy Kerr and Joel Stanley.
>>>>
>>>> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
>>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>>> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
>>>> ---
>>>> Hello Brian and MTD folk,
>>>> Could I please get an ACK for Michael to take this through the powerpc
>>>
>>> As we have some deadlines approaching, I am getting pressure to ensure
>>> this gets merged upstream as quickly as possible, please let me know if
>>> there is anything more which can be done.
>>
>> FYI, Brian is not available for the next 1.5 weeks.
>> So I fear this driver has to wait for the next merge window.
> 
> OK. We'll merge it via the powerpc tree and if there are any problems with it
> we can fix them later.

..or be respectful, have patience and wait for Brian.

Thanks,
//richard
