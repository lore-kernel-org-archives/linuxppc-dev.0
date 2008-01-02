Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82EFFDDE04
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jan 2008 21:54:18 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JA1Ek-0006GA-7t
	for linuxppc-dev@ozlabs.org; Wed, 02 Jan 2008 02:54:14 -0800
Message-ID: <14576412.post@talk.nabble.com>
Date: Wed, 2 Jan 2008 02:54:14 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-dev@ozlabs.org
Subject: How to creat a .config file for a driver and How to use it in a
	device driver?????
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all ...

i am writing a device driver in which the default configuration for LCD
display i need to keep it in a .config file so that as the system boots it
take the value from this file and does the initial configuration in the init
of the driver. If user changes the .config file content in the next boot the
LCD driver should take the new default configuration 

There will also be a run time config which could be changed at the rum time
but will not change the default configuration.


i am writing a LCD driver for PPC arch i need to know that how should i
creat a .config file and How should i use it my device driver. ??????

If you had an exprience in this regard please do share with me ...

----Misbah <><
-- 
View this message in context: http://www.nabble.com/How-to-creat-a-.config-file-for-a-driver-and-How-to-use-it-in-a-device-driver------tp14576412p14576412.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
