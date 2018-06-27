Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41G2b42TNLzF153
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 22:41:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Joshua Thompson <funaho@jurai.org>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Meelis Roos <mroos@linux.ee>,
 Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/3] [v2] powerpc: mac: fix rtc read/write functions
In-Reply-To: <CAK8P3a2HwOe2D4LXgFsfhFXpeUBpHZiB5PCk0nkAwqX3NKCmFA@mail.gmail.com>
References: <20180619140229.3615110-1-arnd@arndb.de>
 <87y3f06e9a.fsf@concordia.ellerman.id.au>
 <CAK8P3a2HwOe2D4LXgFsfhFXpeUBpHZiB5PCk0nkAwqX3NKCmFA@mail.gmail.com>
Date: Wed, 27 Jun 2018 22:41:13 +1000
Message-ID: <87lgb05rme.fsf@concordia.ellerman.id.au>
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

Arnd Bergmann <arnd@arndb.de> writes:
> On Wed, Jun 27, 2018 at 6:32 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> So I think I can take this patch in isolation via the powerpc tree as a
>> fix for 4.18.
>>
>> I'll leave the other two alone.
>
> Yes, that is what I had intended with this series but should have made
> clearer. The two m68k patches are 4.19 material.

OK thanks.

cheers
