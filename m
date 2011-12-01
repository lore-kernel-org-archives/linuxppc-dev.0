Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6BD29B6F6F
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 06:35:18 +1100 (EST)
Subject: Re: Different behaviour when using "nosmp" parameter on SMP and UP
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAL8zT=jgZS2=t0SadUXXshabKPsxHJe_frkfOw5XyF88k3jR=g@mail.gmail.com>
Date: Thu, 1 Dec 2011 13:35:12 -0600
Message-Id: <40F38A2B-48A0-4A8C-B45D-579865F135CC@kernel.crashing.org>
References: <CAL8zT=juU_PC92R4za31R8Lmur0PrFwog1m1fk+PEarW_0C6ng@mail.gmail.com>
 <D70E8CC4-9FA3-4DC9-B623-02F32EFBFE0F@kernel.crashing.org>
 <CAL8zT=gGfBYsLcsKobJPhfhEhNeLcrYMoWh2kv0odT0n0wnZgQ@mail.gmail.com>
 <CAOZdJXVq_g=GAJLRsHZ+290cAJfpOx0LX3sBL3T5i0CaG+xh9Q@mail.gmail.com>
 <CAL8zT=hK2rDDC7s+SkvCA=C5LjVX+5oRQmP+KQet2mkFEnaKKw@mail.gmail.com>
 <CAL8zT=jgZS2=t0SadUXXshabKPsxHJe_frkfOw5XyF88k3jR=g@mail.gmail.com>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 1, 2011, at 11:52 AM, Jean-Michel Hautbois wrote:

> 2011/12/1 Jean-Michel Hautbois <jhautbois@gmail.com>:
>> 2011/12/1 Tabi Timur-B04825 <B04825@freescale.com>:
>>> On Thu, Dec 1, 2011 at 9:04 AM, Jean-Michel Hautbois
>>> <jhautbois@gmail.com> wrote:
>>>> 
>>>> Any idea on how to debug this ? I am using a 2.6.35 kernel.
>>> 
>>> There are a ton of Kconfig options for debugging various locking bugs.
>>>  Try turning them on.
>>> 
> 
> All Kconfig options do not help me with cache coherency problems, though.
> Or, I didn't find any option related.
> Any idea ?
> 
> JM

Nope, if you can't describe the code in any more detail we can't help.

- k
