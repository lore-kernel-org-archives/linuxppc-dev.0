Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A167C1007D7
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Dec 2011 04:51:25 +1100 (EST)
Received: from mail84-ch1 (localhost [127.0.0.1])	by mail84-ch1-R.bigfish.com
 (Postfix) with ESMTP id A508F480460	for <linuxppc-dev@ozlabs.org>;
 Thu,  8 Dec 2011 17:51:08 +0000 (UTC)
Received: from CH1EHSMHS019.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.250])	by mail84-ch1.bigfish.com (Postfix) with ESMTP id
 81823420071
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 17:51:08 +0000 (UTC)
Message-ID: <4EE0F915.2010507@freescale.com>
Date: Thu, 8 Dec 2011 11:51:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: create 32-bit DTS for the P1022DS
References: <1323302665-26461-1-git-send-email-timur@freescale.com>
 <1323302665-26461-2-git-send-email-timur@freescale.com>
 <4EDFFFEA.5030603@freescale.com> <4EE00D6D.70805@freescale.com>
In-Reply-To: <4EE00D6D.70805@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/07/2011 07:05 PM, Tabi Timur-B04825 wrote:
> Scott Wood wrote:
>>> +			interrupts =<8 8 0 0>;
>>>>  +		};
>> It's not new to this patch, but... what does "8" mean in the second cell
>> of an mpic interrupt specifier?
> 
> I have no idea.

Valid values are 0 through 3.

>> And why does the indirect pixis node
>> not have the interrupt?
> 
> Hmmm... I suppose I could add it, but I don't know what good it would do. 
>   The code that's looking for the interrupt is probing on "fsl,p1022ds-fpga".

Is there a reason why this functionality couldn't be used in indirect
mode?  The device tree describes the hardware, not the limitations of
current Linux support.

-Scott
