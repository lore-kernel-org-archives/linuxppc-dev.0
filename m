Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id A14DE679F8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 May 2005 23:44:01 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so1462571wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 May 2005 06:43:59 -0700 (PDT)
Message-ID: <528646bc05051606433f5240ef@mail.gmail.com>
Date: Mon, 16 May 2005 07:43:59 -0600
From: Grant Likely <glikely@gmail.com>
To: Atit_Shah <Atit_Shah@satyam.com>
In-Reply-To: <D8595042F3765A4285B848A78A2C2ED10277B7@bsdmsg002.corp.satyam.ad>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <D8595042F3765A4285B848A78A2C2ED10277B7@bsdmsg002.corp.satyam.ad>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: udhcp problem
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

On 5/12/05, Atit_Shah <Atit_Shah@satyam.com> wrote:
> My configuration is as follows:
>=20
>                         _______________________
>                         |        ROUTER     |
>                         |       ___         ___   |
>                         |_____| |_______| |___|
>                            LAN   WAN
>                                 /\           /\
>                                  |              |
>                    Stand Alone      Company
>                  Windows System    Network
>                            (eth0)       (eth1)
>=20
> I have a udhcp server running on eth0. When I give the command on the
> windows machine "ipconfig /renew", the router assigns an IP address to
> the System in the range 192.168.1.x while the router itself has the IP
> 192.168.1.1 (default). I can ping the router from the system and
> vice-versa.
>=20
> I manually assigned a static IP to eth1 as 172.19.56.x insync with the
> company IP address scheme. I can ping from the router to any other
> system on the network.
>=20
> Now when I try to ping a system or eth1 from the windows machine I get a
> time out. But if I have to manually assign an IP to the windows
> machine(ie not through the udhcp server) I am able to ping eth1 and any
> other system on the network.
>=20
How have you set up routing?  Are you trying to do NAT?  You are
probably going to need to set up some IPTables.  It's more than just a
matter of bringing up both interfaces.  (BTW, congratulations on
getting both ports working now)  Have you read through any of the
networking howtos on linuxdocs.org?

g.
