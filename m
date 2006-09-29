Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 79B6967BC3
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 17:46:22 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k8T7kLFj023905
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 00:46:21 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k8T7kIFq013843
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 02:46:20 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 11/12] Add MPC8360EMDS default dts file
Date: Fri, 29 Sep 2006 15:46:57 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D19DA6D@zch01exm20.fsl.freescale.net>
In-Reply-To: <20060928173816.168d4cc2@vitb.ru.mvista.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
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
> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> Sent: Thursday, September 28, 2006 9:38 PM
> To: Li Yang-r58472
> Cc: paulus@samba.org; galak@kernel.crashing.org;
linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 11/12] Add MPC8360EMDS default dts file
>=20
> On Thu, 28 Sep 2006 16:19:30 +0800
> Li Yang <leoli@freescale.com> wrote:
>=20
> > +		muram@10000 {
> > +			device_type =3D "muram";
> > +			ranges =3D <0 00010000 0000c000>;
> > +
> > +			data-only@0{
> > +				reg =3D <0 c000>;
> > +			};
> > +		};
> > +
>=20
> Why not to have reg property, showing the allocation ranges? data-only
seems
> redundant as a node...

The reason why I added this node is to put the address under "muram"
bus.  If I put the reg in muram node, the address will be offset to QE
base.  But what the driver needs is the offset to MURAM base.  IMHO,
this approach is clearer logically.

- Leo
