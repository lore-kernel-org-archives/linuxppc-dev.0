Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 0215B1A08AC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jun 2015 03:56:48 +1000 (AEST)
Message-ID: <55733453.8090003@c-s.fr>
Date: Sat, 06 Jun 2015 19:56:35 +0200
From: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Rob Herring <robh@kernel.org>
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [BUG] mpc8323_rdb platform doesn't boot since kernel 3.16
References: <5572D773.1090008@c-s.fr>
 <CAL_JsqLRFfjOkzw24EttG4kZtafxki+SgRHXFYoLDfjDBwGmbg@mail.gmail.com>
In-Reply-To: <CAL_JsqLRFfjOkzw24EttG4kZtafxki+SgRHXFYoLDfjDBwGmbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 06/06/2015 17:32, Rob Herring a écrit :
> On Sat, Jun 6, 2015 at 6:20 AM, christophe leroy
> <christophe.leroy@c-s.fr> wrote:
>> I've got a MPC8323 RDB evaluation platform from freescale
>> kernel 4.0 doesn't boot
>> kernel 3.16 doesn't boot
>> kernel 3.15 boots ok
>>
>> I disected the issue down to your commit "of/fdt: Convert FDT functions to
>> use libfdt" (e6a6928c3ea1d0195ed75a091e345696b916c09b)
>>
>> Do you have an idea of what the issue could be ?
> Is your dtb older version of the dtb format (before 0x10)? libfdt
> doesn't work on the older versions.
The dtb is built together with the kernel with following DTS in the 
mainline:
arch/powerpc/boot/dts/mpc832x_rdb.dts
>
> If not, do you have logs with debug enabled in drivers/of/fdt.c?
It stops before any log appears on the console. I will see on monday if 
I can activate early debug console

Christophe
>
> Rob
>
>> Christophe
>>
>> ---
>> L'absence de virus dans ce courrier électronique a été vérifiée par le
>> logiciel antivirus Avast.
>> https://www.avast.com/antivirus
>>


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
