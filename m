Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id AB02ADDE31
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 16:34:33 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2R6YTqJ022036
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Mar 2007 23:34:29 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2R6YReZ027166
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 01:34:28 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Fix MPC83xx SDMA setup errors
Date: Tue, 27 Mar 2007 14:35:58 +0800
Message-ID: <989B956029373F45A0B8AF029708189058F22B@zch01exm26.fsl.freescale.net>
In-Reply-To: <4608481E.8020204@mindspring.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Chuck Meade" <chuckmeade@mindspring.com>, <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Chuck,

The subject and comment of the patch is not accurate.  SDMA is not a
feature of MPC83xx but of QUICC Engine.  That means not all 83xx has
SDMA, and chip other than 83xx can have this feature.  I'd suggest you
change MPC83xx to QE.

- Leo
> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf
Of Chuck
> Meade
> Sent: Tuesday, March 27, 2007 6:25 AM
> To: galak@kernel.crashing.org
> Cc: linuxppc-dev@ozlabs.org
> Subject: [PATCH] Fix MPC83xx SDMA setup errors
>=20
> Correct the alignment of the internal buffer used by the MPC83xx SDMA
> controller to 4Kbytes.  Correct the shift direction in the logic that
> sets up the SDMR register for the MPC83xx SDMA controller.
>=20
> Signed-off-by: Chuck Meade <chuckmeade@mindspring.com>
