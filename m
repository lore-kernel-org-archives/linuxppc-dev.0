Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 059E7B6EEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 08:01:15 +1000 (EST)
References: <1276617907-10862-1-git-send-email-emillbrandt@dekaresearch.com>
	<20100622230026.GA2453@opensource.wolfsonmicro.com>
	<AANLkTiluyeGSwVSXgTeRxS3hVWTe3Gkn8qHrqbHJFMun@mail.gmail.com>
	(sfid-20100626_000520_848782_4E1D9DF3)
Message-Id: <D37786F8-EBA7-4E55-AE83-5D0ABF1E17BF@opensource.wolfsonmicro.com>
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTiluyeGSwVSXgTeRxS3hVWTe3Gkn8qHrqbHJFMun@mail.gmail.com>
	(sfid-20100626_000520_848782_4E1D9DF3)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (iPad Mail 7B367)
Subject: Re: [PATCH 0/2 v3] mpc5200 ac97 gpio reset
Date: Sun, 27 Jun 2010 23:01:53 +0100
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 26 Jun 2010, at 00:04, Grant Likely <grant.likely@secretlab.ca> =
wrote:

> On Tue, Jun 22, 2010 at 5:00 PM, Mark Brown
>> On Tue, Jun 15, 2010 at 12:05:05PM -0400, Eric Millbrandt wrote:
>>> These patches reimplement the reset fuction in the ac97 to use gpio =
pins
>>> instead of using the mpc5200 ac97 reset functionality in the psc.  =
This
>>> avoids a problem in which attached ac97 devices go into "test" mode =
appear
>>> unresponsive.
>>>=20
>>> These patches were tested on a pcm030 baseboard and on custom =
hardware with
>>> a wm9715 audio codec/touchscreen controller.
>>=20
>> Grant, are you OK with this series?
>=20
> Yes, I'm going to pick it up.

I'm a little concerned with a collision with multi codec here. It'd
be handy if you could keep it separate in case it needs merging
into both trees (or we could merge via ASoC only).=
