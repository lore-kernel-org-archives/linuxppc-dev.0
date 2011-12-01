Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 31825B6F6F
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 02:56:48 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: Different behaviour when using "nosmp" parameter on SMP and UP
Date: Thu, 1 Dec 2011 15:56:41 +0000
Message-ID: <CAOZdJXVq_g=GAJLRsHZ+290cAJfpOx0LX3sBL3T5i0CaG+xh9Q@mail.gmail.com>
References: <CAL8zT=juU_PC92R4za31R8Lmur0PrFwog1m1fk+PEarW_0C6ng@mail.gmail.com>
 <D70E8CC4-9FA3-4DC9-B623-02F32EFBFE0F@kernel.crashing.org>
 <CAL8zT=gGfBYsLcsKobJPhfhEhNeLcrYMoWh2kv0odT0n0wnZgQ@mail.gmail.com>
In-Reply-To: <CAL8zT=gGfBYsLcsKobJPhfhEhNeLcrYMoWh2kv0odT0n0wnZgQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
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

On Thu, Dec 1, 2011 at 9:04 AM, Jean-Michel Hautbois
<jhautbois@gmail.com> wrote:
>
> Any idea on how to debug this ? I am using a 2.6.35 kernel.

There are a ton of Kconfig options for debugging various locking bugs.
 Try turning them on.

--=20
Timur Tabi
Linux kernel developer at Freescale=
