Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6wc95TXXzDqRB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 15:46:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Darren Stevens <darren@stevens-zone.net>
Cc: linuxppc-dev@lists.ozlabs.org, Pat Wall <pjwall@mac.com>, rtd@a-eon.com,
 aperez@alexperez.com, Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: powerpc/pasemi/nemo: Fix low memory values for boot.
In-Reply-To: <497a17344e3.4cea1c9d@auth.smtp.1and1.co.uk>
References: <49760dd82b0.759fd78a@auth.smtp.1and1.co.uk>
 <87h94qb8u2.fsf@concordia.ellerman.id.au>
 <497a17344e3.4cea1c9d@auth.smtp.1and1.co.uk>
Date: Tue, 24 Jan 2017 15:46:01 +1100
Message-ID: <87wpdl9iba.fsf@concordia.ellerman.id.au>
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

Darren Stevens <darren@stevens-zone.net> writes:
> On 23/01/2017, Michael Ellerman wrote:
>>> Clearing the long long at addr 8 has been shown to fix this, so
>>> add an initalisation to head_64.S so the system will boot.
>>
>> I'd really prefer it if someone could tell me why we need to clear it.
>> But I assume no one knows?
...
>
> I took a long look today and traced the problem the 'prom_find_boot_cpu' and a
> much better patch will follow.

Awesome work, thanks.

cheers
