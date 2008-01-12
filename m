Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E385EDDDF9
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 13:52:18 +1100 (EST)
Message-ID: <47882B60.8060803@pikatech.com>
Date: Fri, 11 Jan 2008 21:52:16 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/5] Warp Base Platform
References: <47852C41.8000506@pikatech.com><20080111174259.b749f1f0.sfr@canb.auug.org.au><47871675.6030602@pikatech.com><20080111115143.4ed89ab6@zod.rchland.ibm.com><4787FE23.7010201@pikatech.com>
	<20080112134005.a262c95c.sfr@canb.auug.org.au>
In-Reply-To: <20080112134005.a262c95c.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Hi Sean,
>
> On Fri, 11 Jan 2008 18:39:15 -0500 Sean MacLennan <smaclennan@pikatech.com> wrote:
>   
>> +++ arch/powerpc/platforms/44x/warp-nand.c	2008-01-11 18:04:10.000000000 -0500
>> @@ -0,0 +1,85 @@
>>     
>
> You need a copyright/license notice.
>
> The only other concern I have left is the extern in the C file, but that
> can be dealt with later.
>
>   
Oops, meant to reply to everybody. Thanks for the copyright catch. Do I 
need the GPL blurb, or is just a copyright ok? I notice Linux does not 
seem to put the GPL blurb. For example sched.c.

And I also don't like the extern, but I don't see a good solution right now.

And while I have everybody's attention... The FPGA contains a simple 
watchdog timer. Would it be ok to put that in the platform/44x/warp.c 
file? It is a bit too specific to the taco to ever be accepted in the 
drivers/watchdog. Or I could do a warp-watchdog.c .

Cheers,
   Sean
