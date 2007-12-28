Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id A9F19DDE03
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Dec 2007 02:35:55 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How can I support 2GB of memory in Linux kernel on 440SPe
Date: Fri, 28 Dec 2007 09:35:52 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03C7D08F@ismail.innsys.innovsys.com>
In-Reply-To: <d3ef3b090712280559s121d9368nc7bc0edafe2d20f4@mail.gmail.com>
References: <d3ef3b090712280559s121d9368nc7bc0edafe2d20f4@mail.gmail.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Vincitore" <vincitoreg@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> From: linuxppc-embedded-bounces+runet=3Dinnovsys.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+runet=3Dinnovsys.com@ozlabs.or
> g] On Behalf Of Vincitore
> Sent: Friday, December 28, 2007 8:00 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: How can I support 2GB of memory in Linux kernel on 440SPe
>=20
> Hi,
>=20
> I need to support 2GB of memory on a custom 440SPe board.
>=20
> I see to support 1GB of memory on the 440SPe yucca board the following
> configuration changes were done.

Just leave the configuration for 1 GB, and enable CONFIG_HIGHMEM
That gives you 2 (or more) GB of RAM, with 1G as lowmwm.
