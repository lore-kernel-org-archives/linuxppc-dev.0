Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E961DDDE22
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Dec 2007 23:44:09 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1J9Jzz-00058Q-3J
	for linuxppc-embedded@ozlabs.org; Mon, 31 Dec 2007 04:44:07 -0800
Message-ID: <14557204.post@talk.nabble.com>
Date: Mon, 31 Dec 2007 04:44:07 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: How to do IO mapped Implimentation ???
In-Reply-To: <14522349.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <14522349.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


You are absolutly right and i guess it will certainly work for 8248 as well ,
but the only concern is that " here in mine case the register is not memory
mapped where as its IO mapped " we have to consider the memory as IO port
and then access the data ....

What you have used i guess its memory mapped ...Is it that accessing memory
mapped is same as io mapped ?????


---Misbah

Misbah khan wrote:
> 
> Hi all...
> 
> I am writing a driver in which device port is mapped to CPLD and 8 bit
> data bus is directly connected from processor to CPLD. Read write on CPLD
> memory mapped (buffer/register) is required to control the device. This is
> now IO mapped to processor.
> 
> I need to know whether i am right if i impliment like this :-
>          addr=ioremap(base_addr);          // Remap to Mem mapped address
>          outb(addr) and inb(addr);
> 
> Please suggest me if i am wrong or there could be better solution to this
> .
> 
> -----Misbah <><
>          
> 

-- 
View this message in context: http://www.nabble.com/How-to-do-IO-mapped-Implimentation-----tp14522349p14557204.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
