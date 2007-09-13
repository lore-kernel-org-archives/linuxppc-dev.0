Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A35E5DDE24
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 15:32:27 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IVhJQ-0002ow-NQ
	for linuxppc-dev@ozlabs.org; Wed, 12 Sep 2007 22:32:24 -0700
Message-ID: <12648963.post@talk.nabble.com>
Date: Wed, 12 Sep 2007 22:32:24 -0700 (PDT)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: RE: 2.6.23-rc3 boot hang on MPC8641D
In-Reply-To: <46B96294322F7D458F9648B60E15112C85D808@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12648489.post@talk.nabble.com>
	<46B96294322F7D458F9648B60E15112C85D7FB@zch01exm26.fsl.freescale.net>
	<12648696.post@talk.nabble.com>
	<5850B6F4-61FD-4866-B50E-8F7FEA3FA9AD@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C85D808@zch01exm26.fsl.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,
          Sorry i specify the wrong version, we r using 1.2.0. This uboot
was taken from the BSP which was released by Freescale. Previously we tested
linux 2.6.21 kernel, we got linux prompt. For this we are using the same
uboot(1.2.0).
In that version we face some issues in the pci express, at that time kumar
suggest to upgrade the kernel verison 2.6.23-rc3.
Zhang did u suspect the problem is related to uboot?.
by
sivaji


Zhang Wei-r63237 wrote:
> 
> Yes, It's too old. Maybe not fully supports FDT. You can try the version
> of Kumar said or in the BSP of Freescale released.
> 
> - zw
> 
>> -----Original Message-----
>> From: linuxppc-dev-bounces+wei.zhang=freescale.com@ozlabs.org 
>> [mailto:linuxppc-dev-bounces+wei.zhang=freescale.com@ozlabs.or
>> g] On Behalf Of Kumar Gala
>> Sent: Thursday, September 13, 2007 1:11 PM
>> To: sivaji
>> Cc: linuxppc-dev@ozlabs.org
>> Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
>> 
>> 
>> On Sep 12, 2007, at 11:52 PM, sivaji wrote:
>> 
>> >
>> >
>> > Hi,
>> >           I tired to move the dtb to 0x2000000, but the result was  
>> > same.
>> > uboot version is 1.1.6
>> 
>> seems like a pretty old u-boot.  Willing to try a 1.3.0-rc1?
>> 
>> - k
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/2.6.23-rc3-boot-hang-on-MPC8641D-tf4433508.html#a12648963
Sent from the linuxppc-dev mailing list archive at Nabble.com.
