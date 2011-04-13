Return-Path: <schwab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 578B9B6F4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 18:59:26 +1000 (EST)
From: Andreas Schwab <schwab@redhat.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: small git lesson [Was: Re: Revert
	737a3bb9416ce2a7c7a4170852473a4fcc9c67e8 ?]
References: <20110404235259.GA30132@iram.es>
	<20110406084101.GB13963@pengutronix.de>
	<BANLkTimAJ-s_3A3L1YGfoFLmd4bpu2jWVA@mail.gmail.com>
	<20110406204327.GA11148@iram.es>
	<1302185075.24704.143.camel@thor.local>
	<20110411133128.GA24344@iram.es>
	<1302535963.24704.268.camel@thor.local>
	<20110412113033.GA16649@iram.es>
	<1302608770.27054.36.camel@thor.local> <20110413080204.GA3871@iram.es>
	<20110413081246.GK18850__3180.67204575545$1302682420$gmane$org@pengutronix.de>
Date: Wed, 13 Apr 2011 10:59:14 +0200
In-Reply-To: <20110413081246.GK18850__3180.67204575545$1302682420$gmane$org@pengutronix.de>
	("Uwe =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Wed, 13 Apr 2011
	10:12:46 +0200")
Message-ID: <m339lm8r31.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Greg KH <greg@kroah.com>, linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
	Dave Airlie <airlied@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> $ git name-rev --refs=3Drefs/tags/v2.6\* 69a07f0b117a40fcc1a479358d8e1f41=
793617f2
> 69a07f0b117a40fcc1a479358d8e1f41793617f2 tags/v2.6.39-rc2~3^2~43^2~4
>
> so it was introduced just before -rc2.

$ git tag --contains 69a07f0b117a40fcc1a479358d8e1f41793617f2
v2.6.39-rc1
v2.6.39-rc2

Andreas.

--=20
Andreas Schwab, schwab@redhat.com
GPG Key fingerprint =3D D4E8 DBE3 3813 BB5D FA84  5EC7 45C6 250E 6F00 984E
"And now for something completely different."
