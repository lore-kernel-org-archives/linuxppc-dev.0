Return-Path: <michel@daenzer.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EFBEAB7C24
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 08:29:08 +1000 (EST)
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 8E0E7DDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 08:29:07 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git next branch
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1253051488.8375.233.camel@pasglop>
References: <1252653473.8566.98.camel@pasglop>
	<1252999835.8375.205.camel@pasglop>
	<alpine.LFD.2.01.0909150943580.4950@localhost.localdomain>
	<1253051488.8375.233.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Sep 2009 00:29:01 +0200
Message-Id: <1253053741.5669.1990.camel@thor>
Mime-Version: 1.0
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>, FUJITA Tomonori <tomof@acm.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-16 at 07:51 +1000, Benjamin Herrenschmidt wrote:=20
> On Tue, 2009-09-15 at 09:53 -0700, Linus Torvalds wrote:
> > It got a conflict with the AGP merge, but I fixed it up in what _seemed=
_=20
> > to be the obvious manner. But somebody should check out the resulting
> > drivers/char/agp/uninorth-agp.c file.
>=20
> Thanks.=20
>=20
> Michel, can you dbl check it ?

Looks good to me, thanks.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
