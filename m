Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f196.google.com (mail-qy0-f196.google.com
	[209.85.221.196]) by ozlabs.org (Postfix) with ESMTP id 7DCE9DE163
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 02:11:00 +1000 (EST)
Received: by qyk34 with SMTP id 34so965346qyk.17
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 09:10:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090520155346.GG29102@pengutronix.de>
References: <1242806865-2334-1-git-send-email-w.sang@pengutronix.de>
	<9e4733910905200817w20a812bcy14481255fefd011f@mail.gmail.com>
	<20090520155346.GG29102@pengutronix.de>
Date: Wed, 20 May 2009 12:10:59 -0400
Message-ID: <9e4733910905200910r5342c087pa4ebc579b37c8671@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pcm030.dts: add i2c eeprom and delete cruft
From: Jon Smirl <jonsmirl@gmail.com>
To: Wolfram Sang <w.sang@pengutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 20, 2009 at 11:53 AM, Wolfram Sang <w.sang@pengutronix.de> wrot=
e:
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: EEPROM */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeprom@52 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatib=
le =3D "at24,24c32";
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D =
<0x52>;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>
>> Grant suggested this earlier...
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeprom@52 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "atmel,24c32", "eeprom";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x5=
2>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>
> Can you give me a pointer? I just found this thread


Grant, what do you want here?


> http://ozlabs.org/pipermail/devicetree-discuss/2008-July/000008.html
>
> but not the result you proposed.
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
> iEYEARECAAYFAkoUJ4oACgkQD27XaX1/VRsSbwCgo1o//DG1wjKGR7BY1lkRxOAi
> 8kIAoJghKuhKMNBDXUhA4sWj/vRfDoDV
> =3DBmoy
> -----END PGP SIGNATURE-----
>
>



--=20
Jon Smirl
jonsmirl@gmail.com
