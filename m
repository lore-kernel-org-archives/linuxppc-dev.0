Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9D365DDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Aug 2007 09:02:02 +1000 (EST)
Received: from outbound7-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound7-sin-R.bigfish.com (Postfix) with ESMTP id 7E6635112E3
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 23:02:00 +0000 (UTC)
Received: from mail237-sin-R.bigfish.com (unknown [10.3.40.3])
	by outbound7-sin.bigfish.com (Postfix) with ESMTP id 6F6831340060
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 23:02:00 +0000 (UTC)
Received: from mail237-sin (localhost.localdomain [127.0.0.1])
	by mail237-sin-R.bigfish.com (Postfix) with ESMTP id 634E3C58328
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 23:02:00 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail237-sin.bigfish.com (Postfix) with ESMTP id 29AB26B804D
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Aug 2007 23:02:00 +0000 (UTC)
Received: from unknown-38-66.xilinx.com
	([149.199.38.66] helo=xsj-smtp1.xilinx.com
	ident=[U2FsdGVkX19qwMcPsSZ4kiCUnJVi7jhebkGSO3SeKg0=])
	by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <stephen.neuendorffer@xilinx.com>) id 1IIBaJ-00027o-Fx
	for linuxppc-embedded@ozlabs.org; Mon, 06 Aug 2007 16:01:59 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Generic configuration selector for Xilinx devices
Date: Mon, 6 Aug 2007 16:01:57 -0700
In-Reply-To: <20070806225403.B430E550060@mail33-cpk.bigfish.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: <linuxppc-embedded@ozlabs.org>
Message-Id: <20070806230200.29AB26B804D@mail237-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Please consider these a 'first experiment' in generating patches.. :)
Sorry the XILINX_DRIVERS patch took so long, but hopefully things should
be easier after getting the first patch out...

Feedback (especially WRT the structure of the patches and the process
of generating them) is greatly welcome...

Steve

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> =20
> [mailto:linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@oz
labs.org] On Behalf Of Wolfgang Reissnegger
> Sent: Monday, August 06, 2007 3:55 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: [PATCH] Generic configuration selector for Xilinx devices
>=20
> This is intended to make visible all device driver options for
> both powerpc and microblaze systems.
>=20
> Thanks,
>    Wolfgang
>=20
