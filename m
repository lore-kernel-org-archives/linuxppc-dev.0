Return-Path: <tsawyer+linuxppc@sandburst.com>
Received: from sandmail.sandburst.com (sandmail.sandburst.com [216.57.132.42])
	by ozlabs.org (Postfix) with ESMTP id 9F11967A7A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Feb 2005 04:35:16 +1100 (EST)
Received: from [172.16.5.203] (pavement.sandburst.com [172.16.5.203])
	by sandmail.sandburst.com (Postfix) with ESMTP id 922244E98
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Feb 2005 12:17:12 -0500 (EST)
Message-ID: <421F5D98.4020200@sandburst.com>
Date: Fri, 25 Feb 2005 12:17:12 -0500
From: "Travis B. Sawyer" <tsawyer+linuxppc@sandburst.com>
MIME-Version: 1.0
To: ppcembed <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: 2.6 4xx GPIO OCP driver?
Reply-To: tsawyer+linuxppc@sandburst.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings:


I'm working on porting our 'package' of software from a 2.4.x kernel to 2.6.


We use the GPIO on the 440GX for some indications to our user space 
applications (board slot number, other board is present, etc).

In 2.4 we used the drivers/char/ibm_ocp_gpio.c module.  I see no such 
support in 2.6.10.  I perused the archives, found nothing (OBTW: can 
someone point me to the search engine for the list?)

Granted there are many changes in the OCP handling, but I was wondering 
if someone is already working on it, or if I'm going to have to RMO 
(roll my own)/up-port the module.


TIA,

Travis Sawyer
