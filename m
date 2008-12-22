Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7E266DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Dec 2008 04:37:53 +1100 (EST)
Message-ID: <494FD050.7020405@freescale.com>
Date: Mon, 22 Dec 2008 11:37:20 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Daniel Ng <daniel_ng11@lycos.com>
Subject: Re: Device Tree setup for 8272-based board
References: <loom.20081219T062005-806@post.gmane.org>	<494BFE2B.2010103@freescale.com>
	<loom.20081222T064929-412@post.gmane.org>
In-Reply-To: <loom.20081222T064929-412@post.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Daniel Ng wrote:
> Thanks for your helpful responses Scott and Ming Qian. Now, from reading the 
> docco can you please verify my understanding is correct?- 
> 
> First, I need a basic DTS file which will give me a basic Device Tree. The 
> cuboot*.c file takes care of adding other parameters to the Device Tree passed 
> from u-boot via the old bd_info struct. 
> 
> Is this correct? 

Yes.

> If so, would it be possible to do away with the DTS file 
> altogether?

How, other than by encoding all the information about the board in code 
rather than data, which would be a step backwards?

> On the other hand, would it be possible to do away with the 
> cuboot*.c file by providing a complete DTS file?

Yes, though that eliminates the ability to dynamically set certain 
parameters from the firmware.  Better is to use an up-to-date u-boot, 
and have u-boot fill in the dynamic fields (MAC address, clocks, command 
line, etc) directly.

-Scott
