Return-Path: <jhautbois@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
 [209.85.161.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 54CE1B6F6F
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 03:15:20 +1100 (EST)
Received: by faat2 with SMTP id t2so1493062faa.15
 for <linuxppc-dev@ozlabs.org>; Thu, 01 Dec 2011 08:15:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOZdJXVq_g=GAJLRsHZ+290cAJfpOx0LX3sBL3T5i0CaG+xh9Q@mail.gmail.com>
References: <CAL8zT=juU_PC92R4za31R8Lmur0PrFwog1m1fk+PEarW_0C6ng@mail.gmail.com>
 <D70E8CC4-9FA3-4DC9-B623-02F32EFBFE0F@kernel.crashing.org>
 <CAL8zT=gGfBYsLcsKobJPhfhEhNeLcrYMoWh2kv0odT0n0wnZgQ@mail.gmail.com>
 <CAOZdJXVq_g=GAJLRsHZ+290cAJfpOx0LX3sBL3T5i0CaG+xh9Q@mail.gmail.com>
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Date: Thu, 1 Dec 2011 17:14:55 +0100
Message-ID: <CAL8zT=hK2rDDC7s+SkvCA=C5LjVX+5oRQmP+KQet2mkFEnaKKw@mail.gmail.com>
Subject: Re: Different behaviour when using "nosmp" parameter on SMP and UP
To: Tabi Timur-B04825 <B04825@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2011/12/1 Tabi Timur-B04825 <B04825@freescale.com>:
> On Thu, Dec 1, 2011 at 9:04 AM, Jean-Michel Hautbois
> <jhautbois@gmail.com> wrote:
>>
>> Any idea on how to debug this ? I am using a 2.6.35 kernel.
>
> There are a ton of Kconfig options for debugging various locking bugs.
> =C2=A0Try turning them on.
>

And when I do that, it works, even in SMP... :).

JM
