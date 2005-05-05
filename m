Return-Path: <Atit_Shah@satyam.com>
Received: from njpmail.satyam.com (njpmail.satyam.com [204.179.188.132])
	by ozlabs.org (Postfix) with ESMTP id DFA0467A05
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 May 2005 16:34:52 +1000 (EST)
Received: from blr.satyam.com (blr.satyam.com [208.220.245.73])
	by njpmail.satyam.com (8.11.6/8.11.6) with ESMTP id j456HsI26561
	for <linuxppc-embedded@ozlabs.org>; Thu, 5 May 2005 02:18:07 -0400
Received: from Disclaimerbng.corp.satyam.ad
	(IDENT:Sc7gU6fPOil58RSnG0Hod/yG5XOsq4wB@localhost [127.0.0.1])
	by blr.satyam.com (8.11.6/8.11.6) with ESMTP id j456Jh216852
	for <linuxppc-embedded@ozlabs.org>; Thu, 5 May 2005 11:49:43 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 5 May 2005 11:54:55 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED102778C@bsdmsg002.corp.satyam.ad>
From: "Atit_Shah" <Atit_Shah@satyam.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Network Setup - HOW TO
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

	I have a custom board designed to function as a router. It has 2
Ethernet ports. Eth1 is a WAN port and Eth0 is a LAN port. This is what
I wish to do:
1. connect the board/router to my company network=20
2. connect a normal system running windows or linux to the router
3. I should be able to ping or browse the net using the normal system
via the router through the company network.

I have connect the normal network cable (not a cross wire cable) between
the router and the company network. The router does not seem to get a
dynamic IP. Why and What should I do for it to get one?

I assigned a static IP to eth1 and pinged another system on the company
network and I do get a reply back. So my eth1 is working fine, but I
would still prefer a dynamic IP.

I connect a system to eth0 again with a normal network cable (not a
cross wire cable) but the system does not seem to get an IP assigned
even when I run the dhcp server on my router....used udhcpd command. Why
and how can I get it up?

Appreciate a response on this....

Has any one come across a tutorial which could help me solve this

Regards
Atit


DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.
