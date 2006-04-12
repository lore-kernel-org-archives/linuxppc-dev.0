Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 6A41167C99
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 06:15:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: question about Linux 2.6 with Xilinx ML-403
Date: Wed, 12 Apr 2006 13:15:28 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE487104571455@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> >
> > Ethernet? (Hard-Core PLB TEMAC?, Soft-Core PLB EMAC? Localink TEMAC?
Is
> > 10/100/1000 supported, or is there only 1 rate e.g. 1000 supported?)
>=20
> No.  I've ported the 2.4 driver, but I haven't got permission to
> release it yet.  (I'm a contractor; I don't own any of the work I do)
>=20

Which 2.4 driver - there's the "Montavista" one for the softcore PLB
EMAC, and there's also one for the hardcore PLB TEMAC that gets
distributed with the GSRD.

Thanks,
Tim
