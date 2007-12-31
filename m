Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8AA90DDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Dec 2007 17:46:54 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1J9EQE-0005RO-OF
	for linuxppc-embedded@ozlabs.org; Sun, 30 Dec 2007 22:46:50 -0800
Message-ID: <14554843.post@talk.nabble.com>
Date: Sun, 30 Dec 2007 22:46:50 -0800 (PST)
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


yes with respect to ioremap() its right ...i just missed the secound argument
....

in_8() and out_8() will work fine or i need to use in_be8() and out_be8() on
PPC architecture ????

---Misbah<><


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
View this message in context: http://www.nabble.com/How-to-do-IO-mapped-Implimentation-----tp14522349p14554843.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
