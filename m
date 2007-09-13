Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E33E9DDE2B
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 15:24:25 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IVhBe-0002hs-V7
	for linuxppc-dev@ozlabs.org; Wed, 12 Sep 2007 22:24:22 -0700
Message-ID: <12648913.post@talk.nabble.com>
Date: Wed, 12 Sep 2007 22:24:22 -0700 (PDT)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
In-Reply-To: <5850B6F4-61FD-4866-B50E-8F7FEA3FA9AD@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12648489.post@talk.nabble.com>
	<46B96294322F7D458F9648B60E15112C85D7FB@zch01exm26.fsl.freescale.net>
	<12648696.post@talk.nabble.com>
	<5850B6F4-61FD-4866-B50E-8F7FEA3FA9AD@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Hi,
        I am not willing to upgrade the uboot. Becuase it takes some time to
port the new uboot for my custom boad.
whether the current problem is related to uboot ? One more point, previously
i tried 2.6.21 with the same uboot(1.1.6) we got linux prompt but we face
some issue in the pci express in that version. so we plan to upgrade the
kernel version.
by
Sivaji

Kumar Gala-3 wrote:
> 
> 
> On Sep 12, 2007, at 11:52 PM, sivaji wrote:
> 
>>
>>
>> Hi,
>>           I tired to move the dtb to 0x2000000, but the result was  
>> same.
>> uboot version is 1.1.6
> 
> seems like a pretty old u-boot.  Willing to try a 1.3.0-rc1?
> 
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/2.6.23-rc3-boot-hang-on-MPC8641D-tf4433508.html#a12648913
Sent from the linuxppc-dev mailing list archive at Nabble.com.
