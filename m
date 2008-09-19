Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 22179DDEF3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 23:58:09 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 19 Sep 2008 15:57:58 +0200
References: <3E32F84CD6CB95498A35B353CA3B930C01A179F3@fioues08.ebgroup.elektrobit.com>
In-Reply-To: <3E32F84CD6CB95498A35B353CA3B930C01A179F3@fioues08.ebgroup.elektrobit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809191557.59072.jbe@pengutronix.de>
Subject: Re: TQM5200 I2C Second bus
Cc: Jani.Sarkijarvi@elektrobit.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Freitag, 19. September 2008, Jani.Sarkijarvi@elektrobit.com wrote:
> Hi,
>
> I'm using TQM5200 (MPC5200) chip with linux-2.6-denx. Problem is to get
> second I2c bus to work (/dev/i2c-0) . /dev/i2c-1 seems to be internal bus
> and I can read ex. lm75 temperature sensor, also I can see traffic in
> oscilloscope (only error is "I2C: No RXAK", but it seems to be working). =
My
> .dts setup is:

Is your "GPS Port Configuration Register" setting correct?

jbe

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
