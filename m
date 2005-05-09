Return-Path: <Atit_Shah@satyam.com>
Received: from vvamail.satyam.com (vvamail.satyam.com [208.220.247.17])
	by ozlabs.org (Postfix) with ESMTP id D2F65679EA
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 May 2005 15:47:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 9 May 2005 11:16:41 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED102779F@bsdmsg002.corp.satyam.ad>
From: "Atit_Shah" <Atit_Shah@satyam.com>
To: "Grant Likely" <glikely@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
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

My company uses the 172.19.x.x IP addresses, I want a PC with
192.168.x.x IP address to access the company network via a router. I
have a router running Linux and having 2 Ethernet ports. I configured
the systems in the following 2 ways:

1. Eth0 (LAN port) - 172.19.56.218=20
   Eth1 (WAN port) - 172.19.56.219
   Single System   - 192.168.100.10 - IP Address
			   172.19.56.218  - Gateway
			   172.19.56.218  - DNS

2. Eth0 (LAN port) - 192.168.100.20=20
   Eth1 (WAN port) - 172.19.56.219
   Single System   - 192.168.100.10 - IP Address
			   192.168.100.20 - Gateway
			   192.168.100.20 - DNS
	  =09
But I am not able to ping from the router to my single system in either
way.
How should I configure router to make this possible for the 2 networks
to communicate?=20

The second question is how to run DHCP on my router so it can receive a
dynamic IP and assign dynamic IP when I power my router?=20

Atit


-----Original Message-----
From: Grant Likely [mailto:glikely@gmail.com]=20
Sent: Friday, May 06, 2005 8:59 PM
To: Atit_Shah
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Network Setup - HOW TO

On 5/5/05, Atit_Shah <Atit_Shah@satyam.com> wrote:
> Hi all,
>=20
>         I have a custom board designed to function as a router. It has
2
> Ethernet ports. Eth1 is a WAN port and Eth0 is a LAN port. This is
what
> I wish to do:
> 1. connect the board/router to my company network
> 2. connect a normal system running windows or linux to the router
> 3. I should be able to ping or browse the net using the normal system
> via the router through the company network.
>=20
> I have connect the normal network cable (not a cross wire cable)
between
> the router and the company network. The router does not seem to get a
> dynamic IP. Why and What should I do for it to get one?
Are you running a dhcp client?  Let's see the log output
>=20
> I connect a system to eth0 again with a normal network cable (not a
> cross wire cable) but the system does not seem to get an IP assigned
> even when I run the dhcp server on my router....used udhcpd command.
Why
> and how can I get it up?
What do you see on the wire?  Bring up Ethereal to capture traffic.

>=20
> Appreciate a response on this....
Not enough information.  Include output logs please.



DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.
