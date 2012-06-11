Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E76951007D5
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2012 01:12:14 +1000 (EST)
Message-ID: <4FD60AC1.70202@freescale.com>
Date: Mon, 11 Jun 2012 10:12:01 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: P2010 External HW IRQ number?
References: <OF71CEA252.1CE143D5-ONC1257A17.00329573-C1257A17.003D00D0@transmode.se>
 <4FD25146.5090108@freescale.com>
 <OFA31422D6.CC72BDBF-ONC1257A18.0031549A-C1257A18.003183C0@transmode.se>
In-Reply-To: <OFA31422D6.CC72BDBF-ONC1257A18.0031549A-C1257A18.003183C0@transmode.se>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/09/2012 04:00 AM, Joakim Tjernlund wrote:
> 
> 
> Scott Wood <scottwood@freescale.com> wrote on 2012/06/08 21:23:50:
> 
>> From: Scott Wood <scottwood@freescale.com>
>> To: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
>> Cc: <linuxppc-dev@ozlabs.org>
>> Date: 2012/06/08 21:25
>> Subject: Re: P2010 External HW IRQ number?
>>
>> On 06/08/2012 06:06 AM, Joakim Tjernlund wrote:
>>>
>>> I have been trying to figure out what irq number to use for external IRQs for
>>> the P2010. There are no HW IRQ numbers in the ref manual and I cannot find
>>> any examples in the kernel either.
>>> How do specify irq numbers in my dts for external IRQs?
>>
>> See Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
> 
> Ahh, now I see. however I must say that I didn't until I read this older version first:
>  http://os1a.cs.columbia.edu/lxr/source/Documentation/powerpc/dts-bindings/fsl/mpic.txt?a=x86;v=2.6.34

Yeah, while the information is there in the new version, it's should be
more prominent and detailed for something that causes so much confusion.

-Scott
