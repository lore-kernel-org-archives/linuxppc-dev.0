Return-Path: <daniel.schnell@marel.com>
Received: from mail.marel.com (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 4A39BDE458
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 23:26:51 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH]: [MPC5200] Add ATA DMA support
Date: Wed, 6 Aug 2008 13:26:49 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB03202F35@is-hdq-exchange.marel.net>
In-Reply-To: <792f5f410808060518r5e2c0124i2cfef450e264f012@mail.gmail.com>
References: <792f5f410806170128k7e435743x9892b559bd32b157@mail.gmail.com>
	<DD39B5C3F4963040ADC9768BE7E430CB03202EDF@is-hdq-exchange.marel.net>
	<792f5f410808060518r5e2c0124i2cfef450e264f012@mail.gmail.com>
From: "Daniel Schnell" <daniel.schnell@marel.com>
To: "Tim Yamin" <plasm@roo.me.uk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tim Yamin wrote:
> On Wed, Aug 6, 2008 at 12:58 PM, Daniel Schnell
> <daniel.schnell@marel.com> wrote:=20
>> Hi,
>>=20
>> Sorry for testing this patch so late, but I get these if I apply your
>> patch to 2.6.24.7 and use it with my Sandisk Extreme IV 4GB card:
>=20
> Hi,
>=20
> What board are you using? DMA requires a few more signals to be
> routed through correctly to the CF card slot so maybe that's your
> problem... =20
>=20

Hi,

We are using our own MPC5200B based board. Can you be a bit more
specific about which signals have to be routed ?


Best regards,

Daniel Schnell.
