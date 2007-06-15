Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C843DDF57
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 18:22:43 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l5F8MXG4010530
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 01:22:34 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5F8MWYm015698
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 03:22:33 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: for-2.6.23 branch in powerpc.git created
Date: Fri, 15 Jun 2007 16:24:24 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D2AEF5@zch01exm26.fsl.freescale.net>
In-Reply-To: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
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
[mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On Behalf
Of
> Paul Mackerras
> Sent: Friday, June 15, 2007 12:50 PM
> To: linuxppc-dev@ozlabs.org
> Subject: for-2.6.23 branch in powerpc.git created
>=20
> I have created a for-2.6.23 branch in the powerpc.git repository
> (git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git)
> where I have started queueing up patches to go in once the 2.6.23
> merge window opens.  For now at least it's the same as the master
> branch.
>=20
> The patches I put in are listed below.  If you have a patch that
> should go in but isn't listed, remind me about it.

[PATCH] qe_lib: export symbols for QE driver to compile as module
[PATCH v4] 83xx USB platform code rework

- Leo
