Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E3216B70A7
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Aug 2010 04:30:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 9/9] RapidIO: Add support for IDT CPS Gen2 switches
Date: Mon, 16 Aug 2010 11:30:39 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D6074@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C6930EA.8030406@neli.hopto.org>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-10-git-send-email-alexandre.bounine@idt.com>
	<4C6930EA.8030406@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Micha Nelissen" <micha@neli.hopto.org>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, "Bounine,
	Alexandre" <Alexandre.Bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Micha Nelissen wrote:
>=20
> Alexandre Bounine wrote:
> > +	rio_mport_write_config_32(mport, destid, hopcount,
> > +				  LOCAL_RTE_CONF_DESTID_SEL, table);
> > +
> > +	for (i =3D 0x80000000; i <=3D 0x800000ff;) {
> > +		rio_mport_write_config_32(mport, destid, hopcount,
> > +			RIO_STD_RTE_CONF_DESTID_SEL_CSR, i);
>=20
> The 0x80000000 is that an autoincrement bit? If so, it only needs to
do
> this once I think? If so please call it like that, and loop the 'i'
> variable through the destination IDs.

No. This is EXTENDED_CONFIGURATION_ENABLE bit defined in Part 3 of RIO
spec (v.2.1, sect.3.5.4).
Anyway, I should add definition for this bit. Will do now.

Alex.
  =20
