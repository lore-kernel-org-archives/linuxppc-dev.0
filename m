Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id CCDB867B59
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 13:20:43 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k6O3WC96013369
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Jul 2006 20:32:12 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k6O3Grh7003536
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Jul 2006 22:16:55 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc: Add tsi108/9 and new hardware interface to mpic
Date: Mon, 24 Jul 2006 11:16:51 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E071613@zch01exm23.fsl.freescale.net>
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E0456D0@zch01exm23.fsl.freescale.net>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Zang Roy-r61911" <tie-fei.zang@freescale.com>,
	"Paul Mackerras" <paulus@samba.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> The patch add new hardware information table for mpic. This=20
> enables mpic
> code=20
> to deal with OpenPIC controller with hardware behavior difference.
> Add TSI108/109 PIC hardware information table.  The=20
> Tsi108/109 PIC looks
> like=20
> standard OpenPIC but, in fact, is different in registers mapping and
> behavior.
>   =20
> Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
> Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>=20
>=20
> ---

Ben,
	How do you think the new hardware information entry for mpic?
	Thanks.
Roy
