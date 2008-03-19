Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound9-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EE4B8DDEDB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 03:16:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
Date: Wed, 19 Mar 2008 09:16:09 -0700
In-Reply-To: <16137363.post@talk.nabble.com>
References: <16089631.post@talk.nabble.com> <16137363.post@talk.nabble.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Qin Lin" <linkinge@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080319161625.B0FB314A806B@mail53-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>From the data sheet:

"The OPB BUS clock frequency must be greater than or equal to 65 MHz for
100 Mbs Ethernet operation and greater than or equal to 6.5 Mhz for 10
Mbs Ethernet operation"

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Qin Lin
> Sent: Tuesday, March 18, 2008 10:27 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: XUPV2P board opb_emac cannot work with linux-2.6-xlnx
>=20
>=20
> Hi,All
>=20
> I found out what the problem was from.
> When i set the Bus clock frequency to 50MHz and Processor clock
Frequency
> 200MHz, opb_ethernet does not work with the driver.
>=20
> And i check the driver,don't find the code base on the frequency .
Anyone
> knows the reason?
>=20
>=20
>=20
> --
> View this message in context:
http://www.nabble.com/XUPV2P-board-opb_emac-cannot-work-with-linux-2.6-
> xlnx-tp16089631p16137363.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
