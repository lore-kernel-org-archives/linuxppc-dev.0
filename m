Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.202])
	by ozlabs.org (Postfix) with ESMTP id 45E1C67B59
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 May 2005 01:29:01 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so751560wri
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 06 May 2005 08:29:00 -0700 (PDT)
Message-ID: <528646bc05050608292324e4f8@mail.gmail.com>
Date: Fri, 6 May 2005 09:29:00 -0600
From: Grant Likely <glikely@gmail.com>
To: Atit_Shah <Atit_Shah@satyam.com>
In-Reply-To: <D8595042F3765A4285B848A78A2C2ED102778C@bsdmsg002.corp.satyam.ad>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <D8595042F3765A4285B848A78A2C2ED102778C@bsdmsg002.corp.satyam.ad>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Network Setup - HOW TO
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/5/05, Atit_Shah <Atit_Shah@satyam.com> wrote:
> Hi all,
>=20
>         I have a custom board designed to function as a router. It has 2
> Ethernet ports. Eth1 is a WAN port and Eth0 is a LAN port. This is what
> I wish to do:
> 1. connect the board/router to my company network
> 2. connect a normal system running windows or linux to the router
> 3. I should be able to ping or browse the net using the normal system
> via the router through the company network.
>=20
> I have connect the normal network cable (not a cross wire cable) between
> the router and the company network. The router does not seem to get a
> dynamic IP. Why and What should I do for it to get one?
Are you running a dhcp client?  Let's see the log output
>=20
> I connect a system to eth0 again with a normal network cable (not a
> cross wire cable) but the system does not seem to get an IP assigned
> even when I run the dhcp server on my router....used udhcpd command. Why
> and how can I get it up?
What do you see on the wire?  Bring up Ethereal to capture traffic.

>=20
> Appreciate a response on this....
Not enough information.  Include output logs please.
