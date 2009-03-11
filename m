Return-Path: <mark@bish.net>
Received: from vincent.bish.net (bish.net [209.241.232.100])
	by ozlabs.org (Postfix) with ESMTP id 814EADE219
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 02:47:51 +1100 (EST)
Received: from www-data by vincent.bish.net with local (Exim 4.63)
	(envelope-from <mark@bish.net>) id 1LhQtY-0001Um-20
	for linuxppc-dev@ozlabs.org; Wed, 11 Mar 2009 12:03:02 -0400
Message-ID: <20090311120300.atgtikpneo0gos0w@www.bish.net>
Date: Wed, 11 Mar 2009 12:03:00 -0400
From: Mark Bishop <mark@bish.net>
To: linuxppc-dev@ozlabs.org
References: <20090311115234.7hmj4jj79csgk4wo@www.bish.net>
	<A0ED6D80-FD02-4BED-B50B-7F3028E47888@kernel.crashing.org>
In-Reply-To: <A0ED6D80-FD02-4BED-B50B-7F3028E47888@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Subject: Re: Freescale MPC8313ERDB-RevA and newer BSP/kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Yes I have actually.  I have booted a 2.6.28.6.  Same problem.

Also, is it me but at some point from 2.6.23 to 2.6.28 did they =20
started using hex numbers in the .dts file for "interrupts =3D " without =20
the 0x preamble?

I've been looking at 2.6.20, 2.6.23, and 2.6.28 .dts files for this =20
board and .28 looked way different in the interrupt section for the =20
eTSEC.

Quoting Kumar Gala <galak@kernel.crashing.org>:

>
> On Mar 11, 2009, at 10:52 AM, Mark Bishop wrote:
>
>> Has anyone been able to get a newer Freescale BSP to work with a =20
>> RevA (processor version 1.0) RDB?
>>
>> The boards we received didn't have SPI compiled into the kernel and =20
>> when we went to go re-compile the kernel using the 20081222 and =20
>> 20080711 BSPs.  I realize that the interrupts were reversed for =20
>> eTEC1 and eTEC2 and I've made the changes in the .dtb file and I no =20
>> longer hang when I ping, etc.   But I still can't get the board on =20
>> the network.  I've verified it isn't the network settings.
>>
>> I've pinged Freescale for support (didn't help much) and I am now =20
>> looking for someone who has actually done it (if ever).
>
> Have you tried a kernel.org kernel?  The group here would be more =20
> than happy to help with any issues you might find with the =20
> kernel.org kernel.
>
> - k
>
>
