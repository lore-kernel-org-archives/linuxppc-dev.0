Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DECD71A00D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 23:26:30 +1000 (EST)
Message-ID: <53970599.2050508@Freescale.com>
Date: Tue, 10 Jun 2014 08:18:17 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Tony <blacklites@gmail.com>
Subject: Re: <fsl,qman-channel-id> in dts file
References: <CAE1uq6vw0VSDUymckX51FyoJ8NH4Gsj3npfiYeZNff1Vq0cKsQ@mail.gmail.com>
 <5395CC7C.4040608@Freescale.com>
 <CAE1uq6uSEd+NZW+Q+9V8QqxcEDaiQQmcQTJ1GCrgQGL7N98t_g@mail.gmail.com>
In-Reply-To: <CAE1uq6uSEd+NZW+Q+9V8QqxcEDaiQQmcQTJ1GCrgQGL7N98t_g@mail.gmail.com>
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

Hello Tony,


On 06/09/2014 10:28 AM, Tony wrote:
> Thank Emil.
> 
> Where can i find the details about a 'diff' of qman revisions ?

Let me look if someody bothered to write an AN about this

> The code
> i ported doesnt support latest qman revision (REV3).

Ported from what (I suspect) SDK release? v1.5 should already have
support for the latest xMan revision(s)

> Can i still work on
> qman REV1.1 for all the latest targets ? (read t-series)

I'm inclined to say yes (of course the new features will not be
available), but I need to have a look at the code to see with what
limitations


Cheers,


> Regards
> 
> 
> On Mon, Jun 9, 2014 at 8:32 PM, Emil Medve <Emilian.Medve@freescale.com
> <mailto:Emilian.Medve@freescale.com>> wrote:
> 
>     Hello Tony,
> 
> 
>     On 06/09/2014 06:43 AM, Tony wrote:
>     > How's the fsl,qman-channel-id value different for different targets ?
> 
>     Channel ids are assigned in hardware
> 
>     > Is there any document on how this value is achieved ?
> 
>     They are described in the RM of each SoC and in the DPAA RM
> 
>     > Or can it be any value ???
> 
>     Nope. It must be the right value or frames will end up in the wrong
>     portal or worse
> 
> 
>     Cheers,
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
