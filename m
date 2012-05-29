Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 289B8B6FAC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2012 08:58:06 +1000 (EST)
Message-ID: <4FC5546A.4090506@freescale.com>
Date: Tue, 29 May 2012 17:57:46 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anthony Foiani <tkil@scrye.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
References: <ghave7n25.fsf@dworkin.scrye.com>
 <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
 <g7gvzbfhb.fsf@dworkin.scrye.com> <4FC50F22.2040404@freescale.com>
 <gvcjetze3.fsf@dworkin.scrye.com>
In-Reply-To: <gvcjetze3.fsf@dworkin.scrye.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/29/2012 05:07 PM, Anthony Foiani wrote:
> Scott Wood <scottwood@freescale.com> writes:
> 
>> CONFIG_MPC831x_RDB doesn't mean that you're running on such a board,
>> only that the kernel supports those boards.  It should be a runtime
>> test.
> 
> Point taken.
> 
> If that SATA check is CPU/SOC-based, then it should be easy enough to
> test.  The cpuinfo for my board is:
> 
>   # cat /proc/cpuinfo
>   processor       : 0
>   cpu             : e300c3
>   clock           : 266.666664MHz
>   revision        : 2.0 (pvr 8085 0020)
>   bogomips        : 66.66
>   timebase        : 33333333
> 
> On the other hand, if the problem is actually caused by board trace
> routing (or other hardware that's outside the control of the CPU/SOC),
> then I don't know how possible a runtime check will be.

Board information is available from the device tree, and from platform
code that was selected based on the device tree.

> Do you know if there is a specific errata that the MPC8315_DS ran
> across that required this fix, or was it a band-aid in the first
> place?

I don't know the history of this, sorry.  It looks like Yang Li added
this code -- Yang, can you answer this?

-Scott
