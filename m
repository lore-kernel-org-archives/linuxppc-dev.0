Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D8C3BDDF00
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 00:43:04 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l3OEgwDJ026394
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 07:42:59 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l3OEgw2L002390
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 09:42:58 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/6] Consolidate of_get_parent
Date: Tue, 24 Apr 2007 07:42:56 -0700
Message-ID: <AF0367BA48C55940A43CCF08DF35553C011ECCC9@az33exm24.fsl.freescale.net>
In-Reply-To: <20070424224040.6f0fe143.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au><20070403223000.5d44b2f1.sfr@canb.auug.org.au><20070403223136.6ecdabbd.sfr@canb.auug.org.au><20070403223257.cb8c4d15.sfr@canb.auug.org.au><20070403223535.dd6731d6.sfr@canb.auug.org.au><20070403223738.03386a13.sfr@canb.auug.org.au><20070403223914.35bf04e1.sfr@canb.auug.org.au><20070403224039.913af749.sfr@canb.auug.org.au><20070403224205.807cffe0.sfr@canb.auug.org.au><20070403224340.5533abc9.sfr@canb.auug.org.au><20070403224505.5d5a1495.sfr@canb.auug.org.au><20070403224610.b61c7377.sfr@canb.auug.org.au><20070403224937.f6a07e56.sfr@canb.auug.org.au><20070403225059.e735b5e4.sfr@canb.auug.org.au><20070403225222.88e92221.sfr@canb.auug.org.au><20070403230505.f96ea210.sfr@canb.auug.org.au><20070403232406.ab9a3c86.sfr@canb.auug.org.au><20070412141905.6f30efd3.sfr@canb.auug.org.au><20070412153424.bf3957f4.sfr@canb.auug.org.au><20070424223245.78f4fdfb.sfr@canb.auug.org.au>
	<20070424224040.6f0fe143.sfr@canb.auug.org.au>
From: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>,
	"David S. Miller" <davem@davemloft.net>, <paulus@samba.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> This requires creating dummy of_node_{get,put} routines for sparc and
> sparc64.  It also adds a readlocal around the parent accesses.
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Perhaps a read lock?

jdl
