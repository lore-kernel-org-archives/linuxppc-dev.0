Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-6.online-age.net (ext-cn0ut-6.online-age.net
	[63.210.253.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A1256DDE01
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 23:57:01 +1000 (EST)
Received: from int-cn0ut-7.online-age.net (int-cn0ut-7.online-age.net
	[3.159.252.76])
	by ext-cn0ut-6.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m8TDutQJ004023
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 09:56:55 -0400
Received: from cinmlef09.e2k.ad.ge.com (int-cn0ut-7.online-age.net
	[3.159.252.76])
	by int-cn0ut-7.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m8TDupu6000805
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 09:56:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/2] Drop redundant machine type print in show_cpuinfo
Date: Mon, 29 Sep 2008 14:56:41 +0100
Message-ID: <1CADFA951940554D86FBD8B24BBFF3A00230F0B8@LONMLVEM08.e2k.ad.ge.com>
In-Reply-To: <B298C397-2B60-4A05-8F9E-E5038700F20D@kernel.crashing.org>
References: <1222293214-22698-1-git-send-email-becky.bruce@freescale.com>
	<B298C397-2B60-4A05-8F9E-E5038700F20D@kernel.crashing.org>
From: "Welch, Martyn (GE EntSol,
	Intelligent Platforms)" <martyn.welch@gefanuc.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Becky Bruce" <becky.bruce@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Sep 24, 2008, at 4:53 PM, Becky Bruce wrote:
>=20
>> For many of the embedded boards, "model" and "Machine" are printing
>> the same thing; remove the redundant code and allow the generic
>> show_cpuinfo to print the model information.
>>=20
>> Signed-off-by: Becky Bruce <becky.bruce@freescale.com> ---
>> arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    1 -
>> arch/powerpc/platforms/85xx/sbc8560.c             |    1 -
>> arch/powerpc/platforms/86xx/gef_sbc610.c          |    8 --------
>> arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |    8 --------
>> arch/powerpc/platforms/86xx/sbc8641d.c            |    8 --------
>> arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    1 -
>> 6 files changed, 0 insertions(+), 27 deletions(-)
>=20
> Do any of the board maintainers have issue with this change? Martyn,
> Paul?
>=20
> I'm fine w/it for the FSL ones.
>=20
> - k

No problem here.

Martyn

--=20
Martyn Welch MEng MPhil MIET
Principal Software Engineer

GE Fanuc Intelligent Platforms
Tove Valley Business Park, Towcester,
Northants, NN12 6PF, United Kingdom

Telephone: +44 (0) 1327 359444
Direct Dial: +44 (0) 1327 322748
Fax: +44 (0) 1327 322800
email: martyn.welch@gefanuc.com
web: www.gefanuc.com

GE Fanuc Intelligent Platforms Ltd, registered in England and Wales
(3828642) at 100 Barbirolli Square, Manchester, M2 3AB, VAT GB 729 849
476

GE Fanuc Intelligent Platforms Confidential and Proprietary. If you
have received this message in error please notify us immediately and
permanently remove it from your system and destroy any printed
hardcopies. =20
