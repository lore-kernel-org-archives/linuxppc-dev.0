Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59C63DDE01
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 08:40:14 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BC76@az33exm25.fsl.freescale.net>
References: <11713852392294-git-send-email-timur@freescale.com><20070214003119.GF11491@localhost.localdomain><45D29BBA.7090401@freescale.com><20070214052440.GB12609@localhost.localdomain><45D31734.7030808@freescale.com><20070214233348.GH16279@localhost.localdomain>
	<c8fe6c9c19018243871df0fb9ed23a0b@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BC76@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B8882F02-616E-4E71-BECC-82BDE5D88A4E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: purpose of /chosen node (was RE: [PATCH] powerpc: delete boot-cpu
	and chosen nodes from all DTSfiles)
Date: Thu, 15 Feb 2007 15:39:08 -0600
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 15, 2007, at 3:26 PM, Yoder Stuart-B08248 wrote:

>
>
>> -----Original Message-----
>> From: linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org
>> [mailto:linuxppc-dev-bounces+b08248=freescale.com@ozlabs.org]
>> On Behalf Of Segher Boessenkool
>> Sent: Wednesday, February 14, 2007 7:40 PM
>> To: David Gibson
>> Cc: linuxppc-dev@ozlabs.org; Tabi Timur-B04825
>> Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen
>> nodes from all DTSfiles
>>
>>> My point is that the interrupt-controller property in
>> /chosen *should*
>>> be there, but it doesn't make a lot of sense for it to be set by the
>>> bootloader (because it's a fixed property of the board).
>>
>> And that means it shouldn't be in /chosen at all.  It's not
>> just a fixed property of the board, it is a physical property
>> of the board.  It doesn't belong in /chosen.
>
> I agree with Segher here.  The interrupt-controller property doesn't
> belong in /chosen.
>
> The 1275 OF spec says about /chosen:
>
>    Has properties describing parameters chosen or specified at
>    runtime.

I want to reiterate something Paul mentioned, any similarity that the  
device tree has to 1275 is strictly coincidental.

- k
