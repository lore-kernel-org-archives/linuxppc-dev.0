Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3248A67BC7
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 13:21:09 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k8T3L8TN007547
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 20:21:08 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8T3L56p007124
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 22:21:07 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 0/12] Add support for QE and 8360EMDS board -v2
Date: Fri, 29 Sep 2006 11:21:44 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D19D9FB@zch01exm20.fsl.freescale.net>
In-Reply-To: <98C2C73A-F57B-49A6-9727-D76A1AE9746C@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, September 29, 2006 12:37 AM
> To: Li Yang-r58472
> Cc: linuxppc-dev@ozlabs.org; paulus@samba.org
> Subject: Re: [PATCH 0/12] Add support for QE and 8360EMDS board -v2
>=20
>=20
> On Sep 28, 2006, at 11:09 AM, Li Yang wrote:
>=20
> > On 9/28/06, Kumar Gala <galak@kernel.crashing.org> wrote:
> >>
> >> On Sep 28, 2006, at 3:18 AM, Li Yang wrote:
> >>
> >> > Paul,
> >> >
> >> > The series of patches add generic QE infrastructure called
> >> > qe_lib, and MPC8360EMDS board support.  Qe_lib is used by
> >> > QE device drivers such as ucc_geth driver.
> >> >
> >> > This version updates QE interrupt controller to use new irq
> >> > mapping mechanism, addresses all the comments received with
> >> > last submission and includes some style fixes.
> >> >
> >> > v2 change: Change to use device tree for BCSR and MURAM;
> >> > Remove I/O port interrupt handling code as it is not generic
> >> > enough.
> >>
> >> Before accepting any of this code, I'd like to see what the drivers
> >> look like that are using it.  Its hard to make significant
> >> comments w/
> >> o seeing what the consumers of all the 'lib' code look like.
> >
> > Current in-tree user of the lib is driver/net/ucc_geth.c.  There is
> > also QE ATM driver which is included in Alex's 8360sar project.  QE
> > USB host/client drivers are in Freescale LTIB BSP.
>=20
> is there a serial driver?

No.  It is not very necessary to have serial support for QE, as there is
separate DUART SoC.  We can use 8250 serial driver for that.

- Leo
