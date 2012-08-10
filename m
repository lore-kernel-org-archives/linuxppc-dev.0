Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD45F2C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2012 03:05:19 +1000 (EST)
Message-ID: <50253F43.1070706@freescale.com>
Date: Fri, 10 Aug 2012 12:05:07 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [-next] ERROR: "epapr_hypercall_start"
 [drivers/tty/ehv_bytechan.ko] undefined!
References: <CAMuHMdV9dgjdHuz3avU1dubyekcZwT70x=5W+CL7iHQuoC1n_w@mail.gmail.com>
 <1344589138.27290.18.camel@concordia> <1344589252.27290.19.camel@concordia>
In-Reply-To: <1344589252.27290.19.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2012 04:00 AM, Michael Ellerman wrote:
> On Fri, 2012-08-10 at 18:58 +1000, Michael Ellerman wrote:
>> On Fri, 2012-08-10 at 09:43 +0200, Geert Uytterhoeven wrote:
>>> Sicne a few days, powerpc allmodconfig fails with:
>>>
>>> ERROR: "epapr_hypercall_start" [drivers/tty/ehv_bytechan.ko] undefined!
>>> make[2]: *** [__modpost] Error 1
>>> make[1]: *** [modules] Error 2
>>>
>>> http://kisskb.ellerman.id.au/kisskb/buildresult/6883300/
>>
>>
>> Yep, modular build is broken.
>>
>> Since this commit by the looks of it:
>>
>> commit 6d2d82627f4f1e96a33664ace494fa363e0495cb
>> Author: Liu Yu-B13201 <Yu.Liu@freescale.com>
>> Date:   Tue Jul 3 05:48:56 2012 +0000
>>
>>     PPC: Don't use hardcoded opcode for ePAPR hcall invocation
>>     
>>     Signed-off-by: Liu Yu <yu.liu@freescale.com>
> 
> And this address bounces, nice.

He doesn't work here anymore.  We'll take care of the breakage.

-Scott
