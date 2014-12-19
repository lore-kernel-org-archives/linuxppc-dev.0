Return-Path: <matteo.facchinetti@sirius-es.it>
Received: from mx.vmgattei.com (mx.vmgattei.com [77.223.18.35])
 by lists.ozlabs.org (Postfix) with ESMTP id 9C5131A0666
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Dec 2014 20:38:59 +1100 (AEDT)
Received: from localhost (mx.vmgattei.com [127.0.0.1])
 by mx.vmgattei.com (Postfix) with ESMTP id 6C55C1FC9D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Dec 2014 10:38:55 +0100 (CET)
Received: from mx.vmgattei.com ([127.0.0.1])
 by localhost (mx.vmgattei.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FYMteO-bMSeU for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 19 Dec 2014 10:38:54 +0100 (CET)
Message-ID: <5493F229.80605@sirius-es.it>
Date: Fri, 19 Dec 2014 10:38:49 +0100
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
MIME-Version: 1.0
To: alex.popov@linux.com
Subject: Re: Disabled LocalPlus Controller (LPC) clock on MPC512x
References: <5475BE5A.4090503@linux.com> <547D98DF.9000708@sirius-es.it>
 <54901ED3.30207@linux.com>
In-Reply-To: <54901ED3.30207@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/12/2014 13:00, Alexander Popov wrote:
> 02.12.2014 13:47, Matteo Facchinetti пишет:
>> On 26/11/2014 12:49, Alexander Popov wrote:
>>> So starting Linux with clk_ignore_unused bootparam
>>> or inserting dummy LPB reading to some initcall is a temporary fix.
>
> In fact clk_ignore_unused bootparam helps to avoid disabling NFC clock.
> The board crash is reproduced again if I perform the following steps:
> 1. disable NFC clock in uboot by clearing NFC_EN bit in SCCR1 register,
> 2. boot Linux with clk_ignore_unused,
> 3. touch any LPB address.
>

Could you see the Reset Status Register (RSR) after board crash?
When boad reset, you may stop uboot in console and then print the value 
of this register.

This could be help to see what happen internally to the microcontroller.
