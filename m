Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 44C9BB6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Apr 2011 21:16:56 +1000 (EST)
Subject: Re: Revert 737a3bb9416ce2a7c7a4170852473a4fcc9c67e8 ?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20110404235259.GA30132@iram.es>
References: <20110404235259.GA30132@iram.es>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Apr 2011 12:39:21 +0200
Message-ID: <1301999961.24704.69.camel@thor.local>
Mime-Version: 1.0
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Die, 2011-04-05 at 01:52 +0200, Gabriel Paubert wrote:=20
>=20
> Actually I thought that the name radeon_cp that is registered there
> would appear somwhere under /sys (or /proc) but failed to find it...

FWIW the radeon_cp* functions are in drivers/gpu/drm/radeon.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
