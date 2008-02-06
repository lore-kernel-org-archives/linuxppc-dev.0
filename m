Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 00163DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Feb 2008 06:29:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Virtex 4 PPC] Which Linux?
Date: Wed, 6 Feb 2008 11:29:11 -0800
In-Reply-To: <15268468.post@talk.nabble.com>
References: <15268468.post@talk.nabble.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "IngoM" <ingo.maindorfer@ipm.fraunhofer.de>, <linuxppc-embedded@ozlabs.org>
Message-Id: <20080206192914.0A1DD1D0071@mail110-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of IngoM
> Sent: Monday, February 04, 2008 5:55 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: [Virtex 4 PPC] Which Linux?
>=20
>=20
> Hello,
>=20
> we develop a new laser-ranging-system and our hardware freaks have
choosen
> the Virtex 4 FX 12 on the "AVNET FX12 Mini-Module". The system had to
> deliver the raw data via UDP (12 Mbyte/sec) and on TCP the processed
data
> (about 6 Mbyte/sec). When you get the processed data via TCP then no
data
> send by UDP.
>=20
> I'm confused by the following:
>=20
> 1) Hard-TEMAC vs. Soft-TEMAC.
> Avnet provide a demo for the module which using Soft-TEMAC. If I get
it
> right this core has to be licenced. But when ther is a hard-TEMAC why
pay
> for it?

Generally speaking, if you have the hard temac, you should use it.  The
new EDK cores do this transparently. (see
http://www.xilinx.com/bvdocs/ipcenter/data_sheet/xps_ll_temac.pdf)  Note
that the emaclite license has recently been made free, although this
core doesn't support gigabit rates, which it looks like youll need.

Steve
