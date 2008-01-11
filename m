Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C303DDFCA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jan 2008 17:38:12 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JDDWp-00043r-La
	for linuxppc-embedded@ozlabs.org; Thu, 10 Jan 2008 22:38:07 -0800
Message-ID: <14750580.post@talk.nabble.com>
Date: Thu, 10 Jan 2008 22:38:07 -0800 (PST)
From: Smily santhosh <Santhosh.Bachu@lntemsys.com>
To: linuxppc-embedded@ozlabs.org
Subject: Is it required to develope new hub class driver for MPC8272 in
	Montavista ?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Friends,
I have few queries ,
before that let me give details
    Kernel : 2.6.10_mvl401-8272ads - Montavista - MPC8272,
    USB HUB controller : ISP1520BD (Externally Connected - 1- Up Stream port
and 4- Down Stream ports ).
    I am familiar  with mass storage driver.

In kernel  source code (drivers/usb/core/hub), huc.c is present which does
core functionality of hub. And ISP1520 descriptors says it is Class specific
driver not Vendor specific one. So i hope i can use same source hub.c file.  
Am i need to develope any specific driver for it ? (Hope: No) . 
Any thing else i need to do ? Currently i am going through the code(hub.c).
What are the possible test cases to validate hub connection and hub working
?

Any response from you appreciated ?


Santhosh
Sharing the knowledge .. always makes you good. :-)


-- 
View this message in context: http://www.nabble.com/Is-it-required-to-develope-new-hub-class-driver-for-MPC8272-in-Montavista---tp14750580p14750580.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
