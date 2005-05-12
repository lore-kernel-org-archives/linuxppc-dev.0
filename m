Return-Path: <Atit_Shah@satyam.com>
Received: from njpmail.satyam.com (njpmail.satyam.com [204.179.188.132])
	by ozlabs.org (Postfix) with ESMTP id 9A22767B1B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 16:25:08 +1000 (EST)
Received: from blr.satyam.com (blr.satyam.com [208.220.245.73])
	by njpmail.satyam.com (8.11.6/8.11.6) with ESMTP id j4C6GDI19409
	for <linuxppc-embedded@ozlabs.org>; Thu, 12 May 2005 02:16:16 -0400
Received: from Disclaimerbng.corp.satyam.ad
	(IDENT:eJQ53YYhCf12KhZIky/WsoZ6TSdaNasn@localhost [127.0.0.1])
	by blr.satyam.com (8.11.6/8.11.6) with ESMTP id j4C6Iu617917
	for <linuxppc-embedded@ozlabs.org>; Thu, 12 May 2005 11:48:56 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 12 May 2005 11:54:40 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED10277B8@bsdmsg002.corp.satyam.ad>
From: "Atit_Shah" <Atit_Shah@satyam.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Network Setup - HOW TO
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

	I have a custom router and ported the udhcp server/client on it.
My router has 2 ports eth0 - LAN and eth1 - WAN. My setup is as follows:
1.=20
To eth0: connect a stand alone windows machine

when I run the server with the command "uphcpd", it by default runs on
eth0. then on the windows machine when I say "ipconfig /renew", the
router assigns an IP address to the system - perfect.

2.
To eth0: connect to my company network.

when I run the server with the command "uphcpd", it by default runs on
eth0. then when I run the client "udhcpc" the router assigns an IP
address to eth0 obtained from the company server - perfect.

All this happens on eth0 ONLY.

I wish to configure the router as follows:
To eth0: stand alone system
To eth1: company network

The router should get an IP from my company server and assign it to eth1
and then it should assign a IP to my standalone system connected to
eth0. how do I do this?

Regards
Atit Shah


DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.
