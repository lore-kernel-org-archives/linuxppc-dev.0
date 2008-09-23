Return-Path: <Jani.Sarkijarvi@elektrobit.com>
Received: from smtpgw1fi.elektrobit.com (smtpgw1fi.elektrobit.com
	[192.194.253.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtpgw1fi.elektrobit.com",
	Issuer "Elektrobit Group" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 76791DE1A2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Sep 2008 00:39:17 +1000 (EST)
Received: from fioues07.ebgroup.elektrobit.com
	(fioues07.ebgroup.elektrobit.com [172.16.33.117])
	by smtpgw1fi.elektrobit.com (8.13.8/8.13.6) with ESMTP id
	m8NEd9uE003018
	for <linuxppc-embedded@ozlabs.org>; Tue, 23 Sep 2008 17:39:11 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1222180751-31567-37"
Subject: RE: TQM5200 I2C Second bus
Date: Tue, 23 Sep 2008 17:39:05 +0300
Message-ID: <3E32F84CD6CB95498A35B353CA3B930C01C2C6B8@fioues08.ebgroup.elektrobit.com>
In-Reply-To: <200809191557.59072.jbe@pengutronix.de>
References: <3E32F84CD6CB95498A35B353CA3B930C01A179F3@fioues08.ebgroup.elektrobit.com>
	<200809191557.59072.jbe@pengutronix.de>
From: <Jani.Sarkijarvi@elektrobit.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format...

------------=_1222180751-31567-37
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=20
It is very possible that, setting are not right. I found from mpc5200 manua=
l this register: (MBAR + 0x0B00, GPS, GPIO Standard registers). Where shoul=
d be right place to modify those register?

BR,

Jani S=E4rkij=E4rvi

-----Original Message-----
From: Juergen Beisert [mailto:jbe@pengutronix.de]=20
Sent: 19 September 2008 16:58
To: linuxppc-embedded@ozlabs.org
Cc: S=E4rkij=E4rvi, Jani
Subject: Re: TQM5200 I2C Second bus

On Freitag, 19. September 2008, Jani.Sarkijarvi@elektrobit.com wrote:
> Hi,
>
> I'm using TQM5200 (MPC5200) chip with linux-2.6-denx. Problem is to=20
> get second I2c bus to work (/dev/i2c-0) . /dev/i2c-1 seems to be=20
> internal bus and I can read ex. lm75 temperature sensor, also I can=20
> see traffic in oscilloscope (only error is "I2C: No RXAK", but it=20
> seems to be working). My .dts setup is:

Is your "GPS Port Configuration Register" setting correct?

jbe

--
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


------------=_1222180751-31567-37--
