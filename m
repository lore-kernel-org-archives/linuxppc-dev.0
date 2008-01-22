Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ADED4DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jan 2008 00:28:54 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JHJBK-0003Hd-Qx
	for linuxppc-embedded@ozlabs.org; Tue, 22 Jan 2008 05:28:50 -0800
Message-ID: <15018508.post@talk.nabble.com>
Date: Tue, 22 Jan 2008 05:28:50 -0800 (PST)
From: greenlean <jmgomez@atc.ugr.es>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Generated xilinx linux 2.6  image sections
In-Reply-To: <15015244.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <14997109.post@talk.nabble.com>
	<20080121184553.569BF179805C@mail212-sin.bigfish.com>
	<15015244.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Now It's running the problem was the DDR controller I was including the 512
one but I'm working with a 256 DDR module .......

Thanks for the orientation, really usefull.

Bye.


Stephen Neuendorffer wrote:
> 
> The testapps are generated using a different linker script.
> 
> Based on what you sent out, it looks like your EDK design has a memory
> at 0x10000000, but this is
> not reflected in the linux image you've generated.  This makes me
> suspect that you haven't generated the BSP and copied the appropriate
> xparameters file over xparameters_xup.h (assuming you are using
> CONFIG_XILINX_XUPV2P).
> 
> Steve
> 
>> -----Original Message-----
>> From: linuxppc-embedded-bounces+stephen=neuendorffer.name@ozlabs.org
> [mailto:linuxppc-embedded-
>> bounces+stephen=neuendorffer.name@ozlabs.org] On Behalf Of greenlean
>> Sent: Monday, January 21, 2008 5:06 AM
>> To: linuxppc-embedded@ozlabs.org
>> Subject: Generated xilinx linux 2.6 image sections
>> 
>> 
>> Hi all,
>> 
>> I'm trying to boot the 2.6 xilinx kernel downloaded from their git
> server in
>> the XUPV2P board I'm really having troubles (I can't see anything in
> the
>> minicom console terminal). I'm not seeing anything, neither the
> ucompressing
>> kernel string nor the prompt with the memory addresses that kernel
> prompt at
>> first time, so I have started to distrust of anything.
>> 
>>
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 



-- 
View this message in context: http://www.nabble.com/Generated-xilinx-linux-2.6--image-sections-tp14997109p15018508.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
