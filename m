Return-Path: <wg@grandegger.com>
Received: from ngcobalt02.manitu.net (ngcobalt02.manitu.net [217.11.48.102])
 by ozlabs.org (Postfix) with ESMTP id E22BA2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 21:05:05 +1100 (EST)
Message-ID: <50D03FCE.9060003@grandegger.com>
Date: Tue, 18 Dec 2012 11:05:02 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Johannes Braun <jjo.braun@gmail.com>
Subject: Re: tqm5200s phy link toggles between up and down
References: <CADwvPCuBcSnXz1LYYf2ydfdCcz1tV5eBZufEDh5LCaZrmY7W4Q@mail.gmail.com>
 <50D03E16.1080903@grandegger.com>
In-Reply-To: <50D03E16.1080903@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/18/2012 10:57 AM, Wolfgang Grandegger wrote:
> On 12/18/2012 10:44 AM, Johannes Braun wrote:
>> Hello,
>>
>> I hope someone could help me with my problem. Currently I am porting
>> a new kernel (3.3.8) for a tqm5200s based board.
> 
> This is not really a new kernel.
> 
>> The previous kernel was 2.6.23. The new kernel version is needed because
>> of support for a wireless card.
>>
>> The new kernel has problems with my ethernet PHY. The problem occurs only
>> with our hardware. Not with the TQ eval board.
>> The eval board uses a Intel PHY. Our board uses a Marvel 88E6085 PHY.
> 
> Is it a PHY or a switch? If is a switch you need to configure a fixed
> link to the switch. This can be done via dts file.

Here is an example:

http://lxr.linux.no/#linux+v3.7.1/arch/powerpc/boot/dts/charon.dts#L129

> Note the the DSA also supports this chip.

See http://lwn.net/Articles/302333/. But I think it lacks device tree
support.

Wolfgang.
