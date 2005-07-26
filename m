Return-Path: <jpl@xiphos.ca>
Received: from mail.net (custpop.ca.mci.com [142.77.1.111])
	by ozlabs.org (Postfix) with ESMTP id 54B7B67C92
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 01:47:29 +1000 (EST)
Received: from [216.95.199.148] (account jpl@xiphos.ca HELO [192.168.1.169])
	by mail.net (CommuniGate Pro SMTP 4.2.8)
	with ESMTP-TLS id 70653659 for linuxppc-embedded@ozlabs.org;
	Tue, 26 Jul 2005 11:47:27 -0400
Message-ID: <42E65ADE.50209@xiphos.ca>
Date: Tue, 26 Jul 2005 11:46:38 -0400
From: Joshua Lamorie <jpl@xiphos.ca>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <42E555B4.7030904@xiphos.ca>
In-Reply-To: <42E555B4.7030904@xiphos.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Virtex-II Pro - PCI Host
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gidday there,

I think I've found the answer.  The ml310 has a Xilinx EDK project that 
is available online.  Within this project is a collection of files for a 
linux bsp, including many files that would go in the arch/ppc hierarchy. 

I haven't built this for my own board yet, but I will soon and let 
anyone know who is interested how it goes and if there are any patches 
that may be useful.

Joshua

Joshua Lamorie wrote:

> Gidday there,
>
> We are trying to put a PCI host into a Virtex-II Pro.  We have seen 
> that the latest development board from Xilinx (ml310, link at end of 
> email) has PCI host and MontaVista has some form of Linux support.  
> However, I can't seem to find any kernel source around with any of 
> this code.  I could easily have missed it.
>
> Anyone know where I might find this code?
>
> Thanks.
>
> Joshua
>
> p.s. The skinny on the ml310...
> http://www.xilinx.com/products/boards/ml310/current/#pci
>

-- 

Xiphos Technologies
(514) 848-9640 x227
(514) 848-9644 fax

www.xiplink.com
_______________________________________________
The information transmitted is intended only for the
person or entity to which it is addressed and may contain
confidential and/or privileged material.  If you have
received this in error, please contact the sender and delete
this communication and any copy immediately. Thank you.
