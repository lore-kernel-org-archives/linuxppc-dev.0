Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0D039DDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 05:51:06 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/4] Merge dtc and libfdt upstream source
Date: Mon, 12 Nov 2007 10:51:00 -0800
In-Reply-To: <20071112171240.GA4394@loki.buserror.net>
References: <20071112041126.GB2047@localhost.localdomain><20071112041524.C6C5FDDED2@ozlabs.org>
	<20071112171240.GA4394@loki.buserror.net>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Scott Wood" <scottwood@freescale.com>,
	"David Gibson" <david@gibson.dropbear.id.au>
Message-Id: <20071112185103.815A641804C@mail10-cpk.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 > -----Original Message-----
> From:=20
> linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.or
> g=20
> [mailto:linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@o
zlabs.org] On Behalf Of Scott Wood
> Sent: Monday, November 12, 2007 9:13 AM
> To: David Gibson
> Cc: linuxppc-dev@ozlabs.org; Paul Mackerras
> Subject: Re: [PATCH 1/4] Merge dtc and libfdt upstream source
>=20
> On Mon, Nov 12, 2007 at 03:15:24PM +1100, David Gibson wrote:
> > This very large patch incorporates a copy of dtc (including libfdt)
> > into the kernel source, in arch/powerpc/boot/dtc-src.  This=20
> patch only
> > imports the upstream sources verbatim, later patches are needed to
> > actually link it into the kernel Makefiles and use the embedded code
> > during the kernel build.
>=20
> Maybe it should go somewhere outside arch/powerpc, so it can=20
> be used by
> other architectures down the road.
>=20
> -Scott

I second that...

Steve
