Return-Path: <listmember@orkun.us>
Received: from www65.dixiesys.com (ns65a.dixiesys.com [65.254.42.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EDA5067FE1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 01:07:02 +1000 (EST)
Message-ID: <4304A411.40907@orkun.us>
Date: Thu, 18 Aug 2005 10:06:57 -0500
From: Tolunay Orkun <listmember@orkun.us>
MIME-Version: 1.0
To: Tolunay Orkun <listmember@orkun.us>
References: <42FD248D.2040508@orkun.us>
In-Reply-To: <42FD248D.2040508@orkun.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Multiple I2C busses on PPC405
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've not received any reply to my inquiry. Since it was last Friday 
afternoon it might have been missed.

I really do appreciate if someone would suggest a bitbang I2C interface 
driver generic enough to modify. I only need /dev/i2c? support from the 
driver.

Tolunay

Tolunay Orkun wrote:
> I have a working embedded linux on Cogent CSB472 board (PPC405GP) 
> currently based on off 2.4.31. We are already using the I2C bus on 
> PowerPC using hardware I2C driver (IBM IIC I2C Interface) at Fast 
> (400khz) mode.
> 
> We need to add support for yet another (slow) I2C bus with PPC405 being 
> the master and I'm looking at implementing bit bang interface using GPIO 
> pins.
> 
> What is the best way to get this going? I am looking at modifying the 
> bit bang driver (PPC_405_I2C_Algorithm?) for the I/O pins I'll use. 
> Anyone has done something similar. I appreciate all the advice I can get.
> 
> Best Regards,
> Tolunay
> 
> 
> 
