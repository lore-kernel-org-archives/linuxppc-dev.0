Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2DA47DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Sep 2008 21:30:37 +1000 (EST)
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net
	[151.189.8.30])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 8D7C927ACC8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Sep 2008 13:30:31 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 7B62F1B8E41
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Sep 2008 13:30:31 +0200 (CEST)
Received: from webmail17.arcor-online.net (webmail17.arcor-online.net
	[151.189.8.75])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 6000A3425E1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Sep 2008 13:30:31 +0200 (CEST)
Message-ID: <22948792.1220441431367.JavaMail.ngmail@webmail17.arcor-online.net>
Date: Wed, 3 Sep 2008 13:30:31 +0200 (CEST)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Compile new kernel for 5200B w/ ELDK
In-Reply-To: <20080903051818.BCA3F24815@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080903051818.BCA3F24815@gemini.denx.de>
	<1219770125l.5709l.0l@antares> <m2bpz8j5bw.fsf@ohwell.denx.de>
	<1220375903l.5712l.0l@antares>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Wolfgang:=20

> Missing step: build the device tree blob.
[snip]#
> The "bootm" command without arguments does just start the Linux kernel
> image. In this form, it does NOT pass the device tree to the Linux
> kernel. You must use
>=20
> =09=3D> bootm 01000000 - <dtb_addr>
>=20
> instead (after downloading the DTB to the <dtb_addr> address).

Bingo!  Now the kernel comes up, and I can reach out for the next stupid qu=
estions.  Reading more carefully through the wiki, I must admit that I *sho=
uld* have been able to figure that out myself (I come from ARM development =
where it wasn't necessary with u-boot, if you want to hear a stupid excuse.=
..).

Thanks again,
Albrecht.



Jetzt komfortabel bei Arcor-Digital TV einsteigen: Mehr Happy Ends, mehr He=
rzschmerz, mehr Fernsehen! Erleben Sie 50 digitale TV Programme und optiona=
l 60 Pay TV Sender, einen elektronischen Programmf=FChrer mit Movie Star Be=
wertungen von TV Movie. Au=DFerdem, aktuelle Filmhits und spannende Dokus i=
n der Arcor-Videothek. Infos unter www.arcor.de/tv
