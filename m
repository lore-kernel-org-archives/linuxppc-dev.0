Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 6FC4567C4B
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 11:20:54 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7N2daIR004072
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 20:39:36 -0600 (MDT)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k7N1Knlm008015
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 20:20:50 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH ] powerpc: Add tsi108/9 and non standard mpic support
Date: Wed, 23 Aug 2006 09:20:47 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E503@zch01exm23.fsl.freescale.net>
In-Reply-To: <1156266914.10233.26.camel@localhost.localdomain>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Adrian Cox" <adrian@humboldt.co.uk>
Cc: Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> I don't support IPI 2 and IPI 3, though it would be possible=20
> to use the mailbox registers in a similar scheme. This=20
> approach works, but I've not worked out how to cleanly=20
> integrate this with the rest of the MPIC driver, and won't=20
> have any time to do this in the near future.
>=20
It might be better to deal with the tsi108/9 smp support
in a separate file.=20
Roy
