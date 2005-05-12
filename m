Return-Path: <Atit_Shah@satyam.com>
Received: from njpmail.satyam.com (njpmail.satyam.com [204.179.188.132])
	by ozlabs.org (Postfix) with ESMTP id 9C86667B1C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 16:25:08 +1000 (EST)
Received: from blr.satyam.com (blr.satyam.com [208.220.245.73])
	by njpmail.satyam.com (8.11.6/8.11.6) with ESMTP id j4C6GDI19408
	for <linuxppc-embedded@ozlabs.org>; Thu, 12 May 2005 02:16:16 -0400
Received: from Disclaimerbng.corp.satyam.ad
	(IDENT:eJQ53YYhCf12KhZIky/WsoZ6TSdaNasn@localhost [127.0.0.1])
	by blr.satyam.com (8.11.6/8.11.6) with ESMTP id j4C6Iu617914
	for <linuxppc-embedded@ozlabs.org>; Thu, 12 May 2005 11:48:56 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 12 May 2005 11:54:33 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED10277B7@bsdmsg002.corp.satyam.ad>
From: "Atit_Shah" <Atit_Shah@satyam.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: udhcp problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

My configuration is as follows:

			_______________________
			|        ROUTER	    |
			|	___	    ___   |
			|_____| |_______| |___|
			   LAN	 WAN
				/\	     /\
				 |		|
  		   Stand Alone      Company    =20
		 Windows System	   Network
			   (eth0)       (eth1)

I have a udhcp server running on eth0. When I give the command on the
windows machine "ipconfig /renew", the router assigns an IP address to
the System in the range 192.168.1.x while the router itself has the IP
192.168.1.1 (default). I can ping the router from the system and
vice-versa.

I manually assigned a static IP to eth1 as 172.19.56.x insync with the
company IP address scheme. I can ping from the router to any other
system on the network.

Now when I try to ping a system or eth1 from the windows machine I get a
time out. But if I have to manually assign an IP to the windows
machine(ie not through the udhcp server) I am able to ping eth1 and any
other system on the network.

Any ideas as to how and why? If you need more inform please let me
know...


Atit
		=09


DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.
