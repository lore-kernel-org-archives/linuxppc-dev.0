Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f203.google.com (mail-yw0-f203.google.com
	[209.85.211.203]) by ozlabs.org (Postfix) with ESMTP id CC049B7D41
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 07:27:46 +1000 (EST)
Received: by ywh41 with SMTP id 41so4605932ywh.9
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 14:27:44 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4BDEFB13.5060407@freescale.com>
References: <1272659448-23302-1-git-send-email-agust@denx.de>
	<1272659448-23302-2-git-send-email-agust@denx.de>
	<g2tfa686aa41005020754t46934f13hbd5c75a6b7668a54@mail.gmail.com>
	<4BDEFB13.5060407@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 19 May 2010 15:27:24 -0600
Message-ID: <AANLkTilBveOR1aJTgunOq0aqnsGtf1vWHfn8A6uXyoPU@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/mpc5121: add initial support for PDM360NG
	board
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Detlev Zundel <dzu@denx.de>, Markus Fischer <markus.fischer.ec@ifm.com>,
	devicetree-discuss@lists.ozlabs.org,
	Michael Weiss <michael.weiss@ifm.com>, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 3, 2010 at 10:34 AM, Scott Wood <scottwood@freescale.com> wrote=
:
> Grant Likely wrote:
>>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // IPIC
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // interrupts cell =3D <intr #, sense>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // sense values match linux IORESOURCE_IR=
Q_* defines:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // sense =3D=3D 8: Level, low assertion
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // sense =3D=3D 2: Edge, high-to-low chan=
ge
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 //
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ipic: interrupt-controller@c00 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc51=
21-ipic", "fsl,ipic";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <0>;
>>
>> Don't need #address-cells here
>
> #address-cells is required by ePAPR for interrupt controllers if an
> interrupt-map is used.

Why?

/me is too lazy to dig out ePAPR and look.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
