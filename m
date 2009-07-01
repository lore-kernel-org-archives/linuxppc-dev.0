Return-Path: <jonsmirl@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 785C7B7110
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 23:32:49 +1000 (EST)
Received: from mail-vw0-f187.google.com (mail-vw0-f187.google.com
	[209.85.212.187]) by ozlabs.org (Postfix) with ESMTP id AC5FCDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 23:32:48 +1000 (EST)
Received: by vwj17 with SMTP id 17so364786vwj.17
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Jul 2009 06:32:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090701085633.GB3144@pengutronix.de>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<20090630061847.GA24164@pengutronix.de>
	<9e4733910906300642o4f1c0e2cn45423c426e3aff7e@mail.gmail.com>
	<20090701085633.GB3144@pengutronix.de>
Date: Wed, 1 Jul 2009 09:32:46 -0400
Message-ID: <9e4733910907010632g10706084o66720d4616e40865@mail.gmail.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97 driver
From: Jon Smirl <jonsmirl@gmail.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 1, 2009 at 4:56 AM, Wolfram Sang<w.sang@pengutronix.de> wrote:
> Hi Jon,
>
>> Wolfram, do you have any way to test the on the Phytec hardware? The
>> WM9712 on the baseboard supports a touchscreen, is it brought out to a
>> header?
>
> Sorry, I didn't get it: Shall I test something specific?

I don't own a touchscreen.

AFAIK no one has ever plugged a touchscreen into the PCM-973 to see if
works since there hasn't been a driver previously. Just do a general
test so that you can tell customers that it works.

>
> The touchscreen connector is X19 BTW (assuming a PCM-973 baseboard).
>
> Regards,
>
> =A0 Wolfram
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Wo=
lfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkpLJMEACgkQD27XaX1/VRs/cwCgn7p7ffxr8WGoW7MwALkBMKtD
> VtYAoIa5/viinyvFF5cQP3BvH9WP3a5I
> =3DZrq3
> -----END PGP SIGNATURE-----
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
