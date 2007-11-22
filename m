Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2F18DDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Nov 2007 21:27:09 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Iv9H0-0000fu-TF
	for linuxppc-embedded@ozlabs.org; Thu, 22 Nov 2007 02:27:06 -0800
Message-ID: <13894278.post@talk.nabble.com>
Date: Thu, 22 Nov 2007 02:27:06 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Firmware Support for USB Hub
In-Reply-To: <200711211830.02997.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <13877282.post@talk.nabble.com> <474468C5.8080402@freescale.com>
	<200711211830.02997.laurentp@cse-semaphore.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>






Laurent Pinchart-4 wrote:
>=20
> On Wednesday 21 November 2007 18:20, Scott Wood wrote:
>> Misbah khan wrote:
>> > Hi all,
>> >
>> > I am using a 8248 processor which has a USB controller and i need to
>> > connect a USB Hub to it, iam using Montavista Linux .I need to know
>> that
>> > what are the support i need form Montavista or Open source to have an
>> > interface with Usb hub. ???
>> >
>> > Is there any driver that we need to make if so what type ???
>>
>> I don't believe a driver currently exists for CPM USB.
>=20
> There's an experimental out-of-tree driver available at=20
> http://cpm2usb.sourceforge.net/
>=20
> The code is outdated and doesn't work, but that's a starting point.
>=20
> can you suggest me the problems both in terms of H/W S/W and Montavista
> ????
>=20
> If I remember correctly, CPM2 USB host support requires the host to creat=
e
> SOF=20
> packets in software. High system loads will probably mess the bus up. A=
=20
> colleague of mines was told by Freescale to use an external USB controlle=
r=20
> instead of the MPC8248 bundled one.
>=20
> I have posted this quarry to freescale. Anyway if you get more informatio=
n
> could you please share with me ??
>=20
>=20
> ---Misbah <><
> --=20
> Laurent Pinchart
> CSE Semaphore Belgium
>=20
> Chauss=C3=A9e de Bruxelles, 732A
> B-1410 Waterloo
> Belgium
>=20
> T +32 (2) 387 42 59
> F +32 (2) 387 42 75
>=20
> =20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20

--=20
View this message in context: http://www.nabble.com/Firmware-Support-for-US=
B-Hub-tf4850180.html#a13894278
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
