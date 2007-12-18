Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EE6FDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Dec 2007 20:42:15 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1J4Yxo-0003u9-UF
	for linuxppc-embedded@ozlabs.org; Tue, 18 Dec 2007 01:42:12 -0800
Message-ID: <14389002.post@talk.nabble.com>
Date: Tue, 18 Dec 2007 01:42:12 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: USB configuration
In-Reply-To: <20071217213341.630cbdf5@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <14192347.post@talk.nabble.com>
	<20071217213341.630cbdf5@kernel.crashing.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi ...

The montavista version we are using is " 2.6.10_mvl401-8272ads " 

Montavista people says that they are supporting USB host interface ....

but still why i am facing the problem ????

Yes i have enabled generic support but i guess its fine ....

----Misbah <><



Vitaly Bordug-2 wrote:
> 
> On Thu, 6 Dec 2007 05:27:14 -0800 (PST)
> Misbah khan wrote:
> 
>> 
>> HI all ...
>> I have configured the Montavista Kernel for USB support and for
>> PPC8272-ADS board I need to know that how could i test that my USB is
>> working ????
>> 
> 
> I'm not sure what MV version you are trying to use, but there is no
> support for USB host(I am about 8272ads).
> MV supports USB gadget though...
>> Its creating the directory :- /proc/bus/usb/ but doesent contain any
>> file under it ????
>> 
> you enabled generic usb support. But no HW/driver picking it up
>> 
>> its also creating the directory :- /sys/bus/usb/   but doesent
>> contain any file under it ????
>> 
> same reason
>> 
>> Please let me know the procedure to test whether my USB configuration
>> is all right ????
>> 
> First, if you want to use USB host, you'll have to develop the driver
> first or assist someone doing that (there yet another such attempt
> recently initiated - see linuxppc-dev logs)
> 
>> Thank u 
>> Misbah <><
> 
> 
> -- 
> Sincerely, Vitaly
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/USB-configuration-tp14192347p14389002.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
