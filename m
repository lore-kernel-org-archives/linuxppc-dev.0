Return-Path: <johndavi@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.129])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "e32.co.us.ibm.com",
	Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1E99C67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Feb 2005 07:53:07 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j19Kr1H5411940
	for <linuxppc-embedded@ozlabs.org>; Wed, 9 Feb 2005 15:53:01 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j19Kr1X5264826
	for <linuxppc-embedded@ozlabs.org>; Wed, 9 Feb 2005 13:53:01 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j19Kr00V016682
	for <linuxppc-embedded@ozlabs.org>; Wed, 9 Feb 2005 13:53:01 -0700
In-Reply-To: <p0611041bbe2f959b9dda@mail.iridescent.org>
To: "Lawrence E. Bakst" <ml@iridescent.org>
MIME-Version: 1.0
Message-ID: <OF903B0110.E2AB6D67-ON87256FA3.00726A1F-85256FA3.0073324C@us.ibm.com>
From: John F Davis <johndavi@us.ibm.com>
Date: Wed, 9 Feb 2005 15:53:00 -0500
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ppc405 core, VIA VT82C686A chipset, linux_2.4.22_pre5,
 and IDE DMA woes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"Lawrence E. Bakst" <ml@iridescent.org> 
02/09/2005 05:34 AM

To
John F Davis/Raleigh/IBM@ibmus, linuxppc-embedded@ozlabs.org
cc

Subject
Re: ppc405 core, VIA VT82C686A chipset, linux_2.4.22_pre5,      and IDE 
DMA woes






1. Can you say exactly which 405 core you are using?
D4V6

2. Is it Xilinx?
No

3. Have you read all the eratta for your core?
Yes

4. How is the VIA VT82C686A hooked to the 405? Via a bus mastering EBC?

PCI PLB Macro
Best,

leb
