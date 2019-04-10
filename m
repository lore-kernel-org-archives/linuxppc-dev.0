Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6055BC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 15:35:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF10E20818
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 15:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VO833lIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF10E20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fSsF2VGFzDqP9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 01:35:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.17.22; helo=mout.gmx.net;
 envelope-from=j.neuschaefer@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=gmx.net header.i=@gmx.net header.b="VO833lIu"; 
 dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fSpF3cJlzDqQ1;
 Thu, 11 Apr 2019 01:32:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1554910344;
 bh=xA/BnWtun4BOCtmmVM/Q6GGeuQ7oR+arBXiulO7kTmI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VO833lIu4P21uf5TC1WdpXoUowLH2jsF+4HgMeza5cVqMXrKwQb8mqmMAp17CTvnz
 imbY4ub9KUvuoP+plJzhvz4pmmLhbxJAXP8PSaDqXYYZkmGTklro51C1ZtUJUK52EC
 DUufRiOX+xMNBGvqh5Hofoz52XsVgdojoXBUmE5o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnPnu-1gfk561V8w-00hh9T; Wed, 10
 Apr 2019 17:24:34 +0200
Date: Wed, 10 Apr 2019 17:24:24 +0200
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 21/21] docs: hwmon: Add an index file and rename docs to
 *.rst
Message-ID: <20190410152424.GA11536@latitude>
References: <cover.1554893881.git.mchehab+samsung@kernel.org>
 <5ac1fbc7f19192dcd30a184e62e3f7989a5437a4.1554893882.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <5ac1fbc7f19192dcd30a184e62e3f7989a5437a4.1554893882.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:TLAu39kAkvV+JyJofEtse/6D/K/biPwb9iYGF66/M1pJjOfHjSl
 5Gvn9F/iX0LVkfahejNon6kcT3qms/6ipAdpwzk/bcp4CJrO2+ikn2UVt5DmS72xmQYbgAm
 Fwh59tkKvyzys0LmnxFnI4MCbOHN9hjVtoafK6B2JMU0kM0HkZOw/KRixn01devzi7mS8qk
 oGfwAeMn0j3k8kz+gF+Jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GLY0oH3C36g=:bNX/uH3NFKtT9so51D6n/1
 +nUOZrNqd98OA9t18e0aVMNuTaQjCYd7jQThbhsaZLOqn7ZPHcGg5umopwSuJvObJJk6uSSgU
 jMQPe8eq5rDCArt6nlQWaR4hSu+YJhZp6K9g9NSmblC/ezKKU8LaazOXJ33YZ/mjiooNsvJCv
 LwNS5jc8SEH5kxEXWhRE/N+G4qBxIxMFdmATrWK2F/9bVZ2LIkVpcqwRvEltXkHPxy+R7FBqa
 qWciPvuTG/CTlw3aHDjRLRyc0g81HQxLrHy3PedUhZTWp0uKXm+Kod52ub1FDP17ND99GEWC/
 6994u/HoCpW4zy3TfNC2jdBk6c+pvBIQJN7dGor4LGvCGKJWHPi0QpGAOa/54Wybmph0mpm7L
 iO7GC47IhuJo0TaYmMH9xukLtwixlGiB+RJK3R5k3McvHfKzy4xfVFAbIx1gjrBafjK+awfE+
 42AvDWHNqcAnNjn31/IV+xUpzsX7Q7D5SbI+UCIm9AztAKITSOVuD9IeZd0vzZPxzaA11OQf1
 EMdZVXTckfwc2KrKqmuMrM7aUwhXnZivlE1mtLeIRV98tWZ2ZYekTVUBpVbeCZnIdXCLp/Y3P
 HqMtmL194jaddEW38zKmirNVrSuOD8dvIEMSuXxSm+OlfoHltmAZZ2cgJYIc1zwIUxshmpACe
 h2v0r9On0YUJDLZIv3yNCTyFkIWuPxA37qaIbvbuT5QMGbTxcKO5klTjcdtntSHew0oa1oA2n
 bYt0xLeQcxMc6Ivfw0Si8641Xw1sNuLsKWVr2UPTIi7PGy7J5RehLEtmpwCk0r7UmOW9KSASb
 mEMRYWJ2EiBZSo/S/v5mQJTuRGVeaGH2lqVnmqoj/jxMVxaKnI+3n7Hn/Ym6pE1RlsPOKjQR8
 IGbJtkcrNlwZrgj2iouY4ErgRdMEtuHUcxTihA6KlgJa8+2zy8vzkwSZWEef+l
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Dirk Eibach <eibach@gdsys.de>,
 linux-aspeed@lists.ozlabs.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Clemens Ladisch <clemens@ladisch.de>, Kamil Debski <kamil@wypas.org>,
 Marc Hulsman <m.hulsman@tudelft.nl>, devicetree@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>,
 Jim Cromie <jim.cromie@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Joel Stanley <joel@jms.id.au>,
 Guenter Roeck <linux@roeck-us.net>,
 Steve Glendinning <steve.glendinning@shawell.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Rudolf Marek <r.marek@assembler.cz>, linux-arm-kernel@lists.infradead.org,
 linux-hwmon@vger.kernel.org,
 Support Opensource <support.opensource@diasemi.com>,
 George Joseph <george.joseph@fairview5.com>,
 Andreas Werner <andreas.werner@men.de>, Andrew Jeffery <andrew@aj.id.au>,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 Juerg Haefliger <juergh@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 10, 2019 at 08:12:11AM -0300, Mauro Carvalho Chehab wrote:
> Now that all files were converted to ReST format, rename them
> and add an index.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
[...]
> diff --git a/Documentation/hwmon/submitting-patches b/Documentation/hwmon=
/submitting-patches.rst
> similarity index 99%
> rename from Documentation/hwmon/submitting-patches
> rename to Documentation/hwmon/submitting-patches.rst
> index 12540b7d9b50..6120db7556aa 100644
> --- a/Documentation/hwmon/submitting-patches
> +++ b/Documentation/hwmon/submitting-patches.rst

I'd additionally suggest:

diff --git a/Documentation/hwmon/submitting-patches b/Documentation/hwmon/s=
ubmitting-patches.rst
index f88221b46153..0000a86be4b9 100644
--- a/Documentation/hwmon/submitting-patches
+++ b/Documentation/hwmon/submitting-patches.rst
@@ -38,7 +38,7 @@ increase the chances of your change being accepted.
 2. Adding functionality to existing drivers
 -------------------------------------------
=20
-* Make sure the documentation in Documentation/hwmon/<driver_name> is up to
+* Make sure the documentation in Documentation/hwmon/<driver_name>.rst is =
up to
   date.
=20
 * Make sure the information in Kconfig is up to date.
@@ -60,7 +60,7 @@ increase the chances of your change being accepted.
=20
 * Consider adding yourself to MAINTAINERS.
=20
-* Document the driver in Documentation/hwmon/<driver_name>.
+* Document the driver in Documentation/hwmon/<driver_name>.rst.
=20
 * Add the driver to Kconfig and Makefile in alphabetical order.
=20

Thanks,
Jonathan Neusch=C3=A4fer

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlyuCqAACgkQCDBEmo7z
X9ssgw//ZmPBGq00gnKgIkdptmktJsCCdbRKqAnKS97nKt6Ad54+llNhFidFR3ij
Owq03OnpCXcu+3rc9qn/bOEv9QHjUmJ9aBysxuMCjbp5Wm69ItkylykWH6DPik8b
BhloTUt0lnoweWJjZ4qtHyp5xuUlsQ2q6RbGR+BQwgvPA3y3FMuMYnvqi4BmuJs4
B2DHhAUQnwgy+CMGBq62WTLZsWU6O4xAGnPRepoEIP4yf3ikOn5uiyYXeJt9sWmB
7TyiXuM+noRFv5qyyiR695nBSlRZN0W690W2au5d8o1d1zp2tnuNTtljFGPv18S9
gxxRiAzJRiXIGlg9cPZuyu/LD+4NbGwbRv8AfYYTcXyf1ZwLU6/y2VYRt9riJ/Ul
1k5LFmFhHlxicwFJmobOor+AxJYtkb6fXCwJ2fSclBgP5tMYiKz3SjMlFxsiAczd
x5uS/ABnXpJXEy3aOKlF3/GLI2ehMXegPLntmgUYGPHybPxTPgMf4ThsKLN0uovd
f5ZeHCR5EtdFtJuECRIbvAeTs7MyawkdRzABA0dVUXmAxRzNxaU5tpFT8S9/AN1I
wHTaekePAAReHn5G87/nu1RwsRWoLe8TyGkpy3IFCPmcYgGzZSF63tM2X0/eHuPi
Q6PdjLqczbpT3X31fJdJ3q9BEWwy+zsHmKCHB81cYGY1F5fAYIY=
=QA5J
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
