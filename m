Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 07850DDE0D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 12:19:43 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l492JcSp016216
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 19:19:38 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l492JY5h029770
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 21:19:35 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v4 0/7] Add support for 750CL Holly board
Date: Wed, 9 May 2007 10:19:33 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E753C30@zch01exm23.fsl.freescale.net>
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E753B9F@zch01exm23.fsl.freescale.net>
References: <1178572962.2990.197.camel@zod.rchland.ibm.com><7EA18FDD2DC2154AA3BD6D2F22A62A0E753A11@zch01exm23.fsl.freescale.net><20070508104640.GM23995@crusty.rchland.ibm.com>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E753B9F@zch01exm23.fsl.freescale.net>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > On Tue, May 08, 2007 at 11:45:05AM +0800, Zang Roy-r61911 wrote:
> > > >=20
> > > > Hi All,
> > > >=20
> > > > This is round 4 of the patches to support the 750CL Holly=20
> > board, and
> > > > hopefully the last.  They also fix one of the PCI issues=20
> > I was seeing.
> > > Sorry, Maybe I missed your previous comment.
> > > What is the PCI issue? Associated with your board or tsi108/9 ?
> >=20
> > Mostly it was the fact that PIBS (the low level boot=20
> > firmware) setup the PCI
> > bridge in an odd fashion.  The other small issue was that the=20
> > TSI PCI bridge
> > was not being designated as the primary.  Both of these were=20
> > found working
> > with a developer from Tundra.
> That  is great.=20
> I will test your patch on 7448hpc2 board tomorrow and give=20
> the feedback.
> Roy
Patches were fine for 7448hpc2 board.
Patch 7/7 seems broken on current Paul's tree. I fixed it myself.

Roy
