Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0E71DDFB0
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 13:33:54 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n292Xomt023451
	for <linuxppc-dev@ozlabs.org>; Sun, 8 Mar 2009 19:33:50 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n292Xm8n003733
	for <linuxppc-dev@ozlabs.org>; Sun, 8 Mar 2009 21:33:49 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: 83xx: Marking or Allocating Pages as Cache-Inhibited
Date: Mon, 9 Mar 2009 10:33:45 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208916D06C@zch01exm21.fsl.freescale.net>
In-Reply-To: <ed82fe3e0903080819g166e5651rd07956d8f26c0f5a@mail.gmail.com>
References: <64ac01180903052032i75792fa6x864f91c511b3f228@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF73@zch01exm21.fsl.freescale.net>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF75@zch01exm21.fsl.freescale.net>
	<64ac01180903052138k4226022cq840d497dccecd939@mail.gmail.com>
	<D7CCA83BB0796C49BC0BB53B6AB1208916CF87@zch01exm21.fsl.freescale.net>
	<ed82fe3e0903080819g166e5651rd07956d8f26c0f5a@mail.gmail.com>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Tabi Timur-B04825" <timur@freescale.com>
Cc: Ben Menchaca <ben.menchaca@gmail.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur,

See the section 14.7.1 DMA Description Format at page 14-112
of MPC8315ERM rev.1.


> -----Original Message-----
> From: timur.tabi@gmail.com [mailto:timur.tabi@gmail.com] On=20
> Behalf Of Tabi Timur-B04825
> Sent: Sunday, March 08, 2009 11:20 PM
> To: Liu Dave-R63238
> Cc: Ben Menchaca; linuxppc-dev@ozlabs.org
> Subject: Re: 83xx: Marking or Allocating Pages as Cache-Inhibited
>=20
> On Fri, Mar 6, 2009 at 12:49 AM, Liu Dave-R63238=20
> <DaveLiu@freescale.com> wrote:
> > could you try to set '1' to DMA description bit3?
>=20
> Dave,
>=20
> I'm looking at the 8315e reference manual.  What is "DMA=20
> description bit 3"?
>=20
> --
> Timur Tabi
> Linux kernel developer at Freescale
>=20
>=20
