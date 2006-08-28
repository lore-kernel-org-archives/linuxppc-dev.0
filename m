Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 146E667B52
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 14:15:25 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7S5YJ9r025781
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Aug 2006 23:34:19 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k7S4FLXW026160
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Aug 2006 23:15:23 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 4/4] Add MPC8349E MDS device tree source file
	toarch/powerpc/boot/dts
Date: Mon, 28 Aug 2006 12:15:51 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC5A7@zch01exm20.fsl.freescale.net>
In-Reply-To: <20060825115947.0d9ad52f.kim.phillips@freescale.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Phillips Kim-R1AAHA" <Kim.Phillips@freescale.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf
Of Kim
> Phillips
> Sent: Saturday, August 26, 2006 1:00 AM
> To: linuxppc-dev@ozlabs.org
> Subject: [PATCH 4/4] Add MPC8349E MDS device tree source file
> toarch/powerpc/boot/dts

{snip}
> +
> +		pci@8500 {
> +			interrupt-map-mask =3D <f800 0 0 7>;
> +			interrupt-map =3D <
> +
> +					/* IDSEL 0x11 */
> +					 8800 0 0 1 700 14 0
> +					 8800 0 0 2 700 15 0
> +					 8800 0 0 3 700 16 0
> +					 8800 0 0 4 700 17 0

If we are changing sense definition in IPIC, we should change the
mapping to lines like below:
					 8800 0 0 1 700 14 2

- Leo
