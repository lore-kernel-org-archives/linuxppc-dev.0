Return-Path: <Steffen.Rumler@siemens.com>
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
	by ozlabs.org (Postfix) with ESMTP id 0035867A6E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Feb 2005 19:55:48 +1100 (EST)
Message-ID: <42033888.4090706@siemens.com>
Date: Fri, 04 Feb 2005 09:55:36 +0100
From: Steffen Rumler <Steffen.Rumler@siemens.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <4202408A.7050200@siemens.com>
	<754ecc31c2497b32a0c3f6df5ce21881@embeddededge.com>
In-Reply-To: <754ecc31c2497b32a0c3f6df5ce21881@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc <linuxppc-embedded@ozlabs.org>
Subject: Re: uart.c: avoid changing parameter RAM on-the-fly for the console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> would you please read Documentation/CodingStyle and
> try sending the patch again?

What in detail is wrong concerning the coding style ?
Note, this is a serious problem for us.

> Although it doesn't make too much difference in this case,
> 2.4.20 is pretty old and it helps to get patches against
> the latest kernels.

2.4.20 is the kernel we are actually using.

> I suspect there is something else amiss, but I'll take a
> look at it.  What is the speed of the processor and the
> baud rate?

CPU:       MPC859T
CPU clock: 133Mhz
Baud Rate: 19200


Steffen

-- 


--------------------------------------------------------------

Steffen Rumler
ICN CP D NT SW 3
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@siemens.com
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------
