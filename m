Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 5BCBFDDEBC
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 08:09:26 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l1EL9NNS011406
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 14:09:23 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l1EL9LB1028027
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 15:09:21 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] powerpc: delete boot-cpu and chosen nodes from all
	DTSfiles
Date: Wed, 14 Feb 2007 14:09:19 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1B8C6@az33exm25.fsl.freescale.net>
In-Reply-To: <1171486473.20192.147.camel@localhost.localdomain>
References: <1171409687840-git-send-email-timur@freescale.com>
	<1171411075.20192.116.camel@localhost.localdomain>
	<45D29AE5.7090004@freescale.com>
	<1171430877.20192.133.camel@localhost.localdomain>
	<45D29EB1.5060801@freescale.com>
	<1171431334.20192.138.camel@localhost.localdomain>
	<45D316CD.9070901@freescale.com>
	<1171486473.20192.147.camel@localhost.localdomain>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Tabi Timur-B04825" <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
> Sent: Wednesday, February 14, 2007 2:55 PM

[snip]

> > Obviously, the kernel needs a 'chosen' section, and that's=20
> why U-Boot=20
> > adds one.  And since U-Boot adds one, the DTS itself=20
> doesn't need one.=20
> > Does the 8272 never use U-Boot?
>=20
> I'm not talking specifically about the 8272. I think we should at it
> back to all dts's

Why do we need the chosen node in the dts files?   Is it to generalize
the dts files for use beyond u-boot?

What meaningful properties should it have in the dts?

Stuart
