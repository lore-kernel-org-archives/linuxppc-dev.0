Return-Path: <pantelis@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 4DA60689D7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jan 2006 18:55:38 +1100 (EST)
From: Pantelis Antoniou <pantelis@embeddedalley.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Question about SCC Ethernet driver
Date: Wed, 18 Jan 2006 09:52:03 +0200
References: <20060118012837.70518.qmail@web32113.mail.mud.yahoo.com>
	<f1e571d3a8b8813c95659dea615cace9@embeddededge.com>
In-Reply-To: <f1e571d3a8b8813c95659dea615cace9@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Message-Id: <200601180952.04344.pantelis@embeddedalley.com>
Reply-To: pantelis@embeddedalley.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 18 January 2006 04:04, Dan Malek wrote:
>=20
> On Jan 17, 2006, at 8:28 PM, David Tao wrote:
>=20
> > Present MPC8260 SCC Ethernet driver supports=A0one 10M Ethernet port fo=
r=20
> > SCC1 or SCC2.
>=20
> Not any more.  Take a look at drivers/net/fs_enet in the 2.6 kernels.
> I'm sure Pantelis will have more information when he reads this.
>=20

The current driver (fs_enet) can handle enets on every SCC. Nobody has
tested this configuration yet however.

> > 1. Is it possible to=A0implement 7 Ethernet ports (3 FCCs and 4 SCCs) o=
n=20
> > a MPC8270? I didn't see any hardware restriction on this. Performance=20
> > may be an issue?=A0
>=20
> Depends what you want to do with the data in the CPU core and the
> clock speeds you have chosen.  The CPM can handle the data traffic on
> the wires if you run it over 133 MHz.
>

Your main problem will be dual port RAM conflicts with other peripheral.
In theory CPM can handle it.

> Thanks.
>=20
> 	-- Dan
>=20

Regards

Pantelis
