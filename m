Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B2838DDEBB
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 17:03:50 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6P73gq9029680
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 00:03:43 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6P73d5b020427
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 02:03:40 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] Add a new member name to structure irq_host
Date: Wed, 25 Jul 2007 15:03:40 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C74CEB4@zch01exm26.fsl.freescale.net>
In-Reply-To: <1185269802.5439.246.camel@localhost.localdomain>
References: <11851892302391-git-send-email-g.chen@freescale.com>
	<11851892311178-git-send-email-g.chen@freescale.com>
	<1185228277.5439.141.camel@localhost.localdomain>
	<1185232974.13740.11.camel@concordia.ozlabs.ibm.com>
	<1185233771.5439.153.camel@localhost.localdomain>
	<995B09A8299C2C44B59866F6391D2635A69C88@zch01exm21.fsl.freescale.net>
	<1185251600.5439.204.camel@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C74CDC2@zch01exm26.fsl.freescale.net>
	<1185269802.5439.246.camel@localhost.localdomain>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Chen Gong-B11801 <G.Chen@freescale.com>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Ben,

Thanks!=20

> Sure, hence the word 'optional' which would provide a default name.
>=20

About the default name, since platforms we touched are very limited, we
do not know which name should be proper default name. We just assign
those default name to 'NULL'  for passing the compiling process. And the
platform maintain can correct it.

Cheers!
Wei.
