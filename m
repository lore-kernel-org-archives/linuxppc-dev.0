Return-Path: <mcr@sandelman.ottawa.on.ca>
Received: from pike.sandelman.ca (pike.sandelman.ca [205.150.200.164])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "pike.sandelman.ca",
	Issuer "Michael Richardson" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C2FB4679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jul 2005 00:34:31 +1000 (EST)
To: "Absolut Hunter" <absoluthunter@comcast.net>
In-Reply-To: Message from "Absolut Hunter" <absoluthunter@comcast.net>
	of "Mon,
	11 Jul 2005 06:38:11 PDT." <20050711134713.D767067C13@ozlabs.org>
References: <20050711134713.D767067C13@ozlabs.org> 
Date: Mon, 11 Jul 2005 10:01:48 -0400
Message-ID: <6071.1121090508@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux 2.4.25 / MPC8280 / ram config vs Linux instability? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Absolut" == Absolut Hunter <absoluthunter@comcast.net> writes:
    Absolut> If I leave the SRAM mapped at higher addresses 0x10000000
    Absolut> and SDRAM at 0x00000000, like U-boot defaults to Linux
    Absolut> works great. However, my goal is to map SRAM <8ns speeds>
    Absolut> down to the address 0x00000000, to map the vector table, so
    Absolut> I can achieve a very fast interrupt response time.

  Are you mapping the SRAM *OVER* the lower 2MB of address space?

  If so, then you won't have 34Mb of ram, you'll have 32Mb, and Linux
may well be running off the end under stress.

  My memory is that you can move the vector table to another address.
Wouldn't that be easier?

- -- 
] Michael Richardson          Xelerance Corporation, Ottawa, ON |  firewalls  [
] mcr @ xelerance.com           Now doing IPsec training, see   |net architect[
] http://www.sandelman.ca/mcr/    www.xelerance.com/training/   |device driver[
]                    I'm a dad: http://www.sandelman.ca/lrmr/                 [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQtJ7yoqHRg3pndX9AQF+eQQA0QBhaZAjq3vDQm8glqV0j+jmzO9+7U0m
aZvOt5FsXu2mv3lS/2FySIQf3UuRcl0lIR5zaNfyn+I11K0YlfZvXgY97U2TMcmu
1K5sod0j3DpaIrK/a+VyWa+tQFe9zoPktazinVoQm4+geNRlTZf9P5XyYwXE7knn
+TOTFRzLq7c=
=iPOS
-----END PGP SIGNATURE-----
