Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B5363B6EDF
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Aug 2010 23:58:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/9] RapidIO: Add the ingress port number into the RIO
	switch data structure
Date: Mon, 16 Aug 2010 06:40:09 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D5F04@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C692BBB.8090707@neli.hopto.org>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-4-git-send-email-alexandre.bounine@idt.com>
	<4C692BBB.8090707@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Micha Nelissen" <micha@neli.hopto.org>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
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
> > A switch ingress port number has to be saved for software assisted
error
> > recovery from the error-stopped state. Saving this information also
allows
> > to remove several register reads from the RIO enumeration process.
>=20
> Why not keep using the swpinfo field, as you can extract it from
there?
> And your code actually does this.
>=20
> Also processor devices can have multiple ports (not only switches), it
> would be good to be ready for that use case.
>=20
Agree. I missed the Multiport bit introduced in RIO spec 2.1. Now it is
justified to be as it was before.
I will rework this and next patches.=20
