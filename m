Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 83EBDB6F0E
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Aug 2010 03:48:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/9] RapidIO: Add relation links between RIO device
	structures
Date: Tue, 17 Aug 2010 10:47:59 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D6317@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C6A3573.3070403@neli.hopto.org>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-5-git-send-email-alexandre.bounine@idt.com>
	<4C692C9D.6040100@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552011D5F1F@CORPEXCH1.na.ads.idt.com>
	<4C6A3573.3070403@neli.hopto.org>
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
> I agree it's desirable to have this information. Notes:
> 1) is rio_dev->prev used anywhere? (maybe I missed it)

It is used to scan route back when servicing an orphaned PW message.
I also see its future use when invalidating route(s) in case of device
removal.
 =20
> 2) is the nextdev[port] list complete? I mean are all connected
switches
> in the list? My guess is that multiply connected switches are
enumerated
> only once therefore only appear in the nextdev if only one switch,
> instead of all
> 3) it would be nice to have all switch connections information.

Good catch. I will address this.

> In case ever the network is rerouted, this information will become
> useful; instead of having a tree representation of the network only.

I consider proposed implementation as transitional until enumeration
logic is reworked.
It already is an attempt to move towards a tree representation. Making
switch support=20
available was given higher priority compared to other things needed for
RIO subsystem. =20

Alex.
