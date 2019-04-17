Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294D5C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 17:16:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43081206BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 17:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RrR24MR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43081206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kpnB1zx6zDqN5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 03:16:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="RrR24MR1"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kplC45CzzDqMy;
 Thu, 18 Apr 2019 03:15:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZX1AJ2NK949U2feFkRHBNbDJXi6UEfizs1P6pACPzJE=; b=RrR24MR1GyiWYjJB7XruLq6blM
 bWwD/LLzNfRgrr8hRFWEaq4rPwAg+v9y/c0ZzsFwLFi6ZrcXy5k+7CdDCo/MVbGGUgmaTy9f+WSEY
 MiefM1TGoBj6smbMeu3c0lhy9XQU5756V6udNthVDhOHFcg3u8czOLGcQOMh//egFgcOzVQ/pKUkL
 eqQR6pyZ3GvxCkrb5ByF4B0lwzDxbsFGSlEBU+hIWwzqiCsvkU+kZ/RTIXgbv85phaFncZowM/ubW
 c4r+NfBmryhPC37DPRfxMMm8c1tpSG/6BXEFB+USBbwwkg3BFKm7Eh/X7HDdG6XckfOmjvv1aInL2
 LO8vyJSA==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hGo8K-0007KI-OY; Wed, 17 Apr 2019 17:14:06 +0000
Date: Wed, 17 Apr 2019 14:13:52 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 21/21] docs: hwmon: Add an index file and rename docs
 to *.rst
Message-ID: <20190417141352.3225bbb3@coco.lan>
In-Reply-To: <20190417164741.GA12147@roeck-us.net>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
 <efbe0a2b5be35026c3a2dbdb9090c4fbd932c9a2.1555494108.git.mchehab+samsung@kernel.org>
 <20190417164741.GA12147@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Em Wed, 17 Apr 2019 09:47:41 -0700
Guenter Roeck <linux@roeck-us.net> escreveu:

> On Wed, Apr 17, 2019 at 06:46:29AM -0300, Mauro Carvalho Chehab wrote:
> > Now that all files were converted to ReST format, rename them
> > and add an index.
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > Acked-by: Liviu Dudau <liviu.dudau@arm.com> =20
>=20
> I applied all patches except this one, which fails due to a conflict in
> ab8500. I also notice that this file has not been touched by your series,
> which is odd. At the same time, patch 20/21 is missing from your series,
> and has been missing all along. Does the missing patch possibly touch
> Documentation/hwmon/ab8500 ?

Patch 20/21 is the biggest one. Maybe vger rejected it either due to
its size or due to the number of c/c.

Just bounced it to you. Please let me know if you didn't receive it
yet.

Regards,
Mauro

>=20
> Thanks,
> Guenter
>=20
> > ---
> >  .../devicetree/bindings/hwmon/g762.txt        |   2 +-
> >  Documentation/hwmon/{ab8500 =3D> ab8500.rst}    |   2 +-
> >  ...guru-datasheet =3D> abituguru-datasheet.rst} |   0
> >  .../hwmon/{abituguru =3D> abituguru.rst}        |   0
> >  .../hwmon/{abituguru3 =3D> abituguru3.rst}      |   0
> >  Documentation/hwmon/{abx500 =3D> abx500.rst}    |   0
> >  ...{acpi_power_meter =3D> acpi_power_meter.rst} |   2 +-
> >  Documentation/hwmon/{ad7314 =3D> ad7314.rst}    |   0
> >  .../hwmon/{adc128d818 =3D> adc128d818.rst}      |   0
> >  Documentation/hwmon/{adm1021 =3D> adm1021.rst}  |   0
> >  Documentation/hwmon/{adm1025 =3D> adm1025.rst}  |   0
> >  Documentation/hwmon/{adm1026 =3D> adm1026.rst}  |   0
> >  Documentation/hwmon/{adm1031 =3D> adm1031.rst}  |   0
> >  Documentation/hwmon/{adm1275 =3D> adm1275.rst}  |   4 +-
> >  Documentation/hwmon/{adm9240 =3D> adm9240.rst}  |   0
> >  Documentation/hwmon/{ads1015 =3D> ads1015.rst}  |   0
> >  Documentation/hwmon/{ads7828 =3D> ads7828.rst}  |   0
> >  Documentation/hwmon/{adt7410 =3D> adt7410.rst}  |   0
> >  Documentation/hwmon/{adt7411 =3D> adt7411.rst}  |   0
> >  Documentation/hwmon/{adt7462 =3D> adt7462.rst}  |   1 -
> >  Documentation/hwmon/{adt7470 =3D> adt7470.rst}  |   0
> >  Documentation/hwmon/{adt7475 =3D> adt7475.rst}  |   0
> >  Documentation/hwmon/{amc6821 =3D> amc6821.rst}  |   1 -
> >  Documentation/hwmon/{asb100 =3D> asb100.rst}    |   1 -
> >  Documentation/hwmon/{asc7621 =3D> asc7621.rst}  |   0
> >  ...{aspeed-pwm-tacho =3D> aspeed-pwm-tacho.rst} |   0
> >  .../hwmon/{coretemp =3D> coretemp.rst}          |   0
> >  Documentation/hwmon/{da9052 =3D> da9052.rst}    |   0
> >  Documentation/hwmon/{da9055 =3D> da9055.rst}    |   0
> >  Documentation/hwmon/{dme1737 =3D> dme1737.rst}  |   0
> >  Documentation/hwmon/{ds1621 =3D> ds1621.rst}    |   0
> >  Documentation/hwmon/{ds620 =3D> ds620.rst}      |   0
> >  Documentation/hwmon/{emc1403 =3D> emc1403.rst}  |   0
> >  Documentation/hwmon/{emc2103 =3D> emc2103.rst}  |   0
> >  .../hwmon/{emc6w201 =3D> emc6w201.rst}          |   0
> >  Documentation/hwmon/{f71805f =3D> f71805f.rst}  |   0
> >  .../hwmon/{f71882fg =3D> f71882fg.rst}          |   0
> >  .../hwmon/{fam15h_power =3D> fam15h_power.rst}  |   0
> >  .../hwmon/{ftsteutates =3D> ftsteutates.rst}    |   0
> >  Documentation/hwmon/{g760a =3D> g760a.rst}      |   0
> >  Documentation/hwmon/{g762 =3D> g762.rst}        |   2 +-
> >  Documentation/hwmon/{gl518sm =3D> gl518sm.rst}  |   0
> >  Documentation/hwmon/{hih6130 =3D> hih6130.rst}  |   0
> >  ...on-kernel-api.txt =3D> hwmon-kernel-api.rst} |   4 +-
> >  .../hwmon/{ibm-cffps =3D> ibm-cffps.rst}        |   0
> >  Documentation/hwmon/{ibmaem =3D> ibmaem.rst}    |   0
> >  .../hwmon/{ibmpowernv =3D> ibmpowernv.rst}      |   0
> >  Documentation/hwmon/{ina209 =3D> ina209.rst}    |   0
> >  Documentation/hwmon/{ina2xx =3D> ina2xx.rst}    |   2 +-
> >  Documentation/hwmon/{ina3221 =3D> ina3221.rst}  |   0
> >  Documentation/hwmon/index.rst                 | 179 ++++++++++++++++++
> >  Documentation/hwmon/{ir35221 =3D> ir35221.rst}  |   0
> >  Documentation/hwmon/{it87 =3D> it87.rst}        |   0
> >  Documentation/hwmon/{jc42 =3D> jc42.rst}        |   0
> >  Documentation/hwmon/{k10temp =3D> k10temp.rst}  |   0
> >  Documentation/hwmon/{k8temp =3D> k8temp.rst}    |   0
> >  .../hwmon/{lineage-pem =3D> lineage-pem.rst}    |   0
> >  Documentation/hwmon/{lm25066 =3D> lm25066.rst}  |   2 +-
> >  Documentation/hwmon/{lm63 =3D> lm63.rst}        |   0
> >  Documentation/hwmon/{lm70 =3D> lm70.rst}        |   0
> >  Documentation/hwmon/{lm73 =3D> lm73.rst}        |   0
> >  Documentation/hwmon/{lm75 =3D> lm75.rst}        |   0
> >  Documentation/hwmon/{lm77 =3D> lm77.rst}        |   0
> >  Documentation/hwmon/{lm78 =3D> lm78.rst}        |   0
> >  Documentation/hwmon/{lm80 =3D> lm80.rst}        |   0
> >  Documentation/hwmon/{lm83 =3D> lm83.rst}        |   0
> >  Documentation/hwmon/{lm85 =3D> lm85.rst}        |   0
> >  Documentation/hwmon/{lm87 =3D> lm87.rst}        |   0
> >  Documentation/hwmon/{lm90 =3D> lm90.rst}        |   0
> >  Documentation/hwmon/{lm92 =3D> lm92.rst}        |   0
> >  Documentation/hwmon/{lm93 =3D> lm93.rst}        |   0
> >  Documentation/hwmon/{lm95234 =3D> lm95234.rst}  |   0
> >  Documentation/hwmon/{lm95245 =3D> lm95245.rst}  |   0
> >  Documentation/hwmon/{ltc2945 =3D> ltc2945.rst}  |   0
> >  Documentation/hwmon/{ltc2978 =3D> ltc2978.rst}  |   0
> >  Documentation/hwmon/{ltc2990 =3D> ltc2990.rst}  |   0
> >  Documentation/hwmon/{ltc3815 =3D> ltc3815.rst}  |   0
> >  Documentation/hwmon/{ltc4151 =3D> ltc4151.rst}  |   0
> >  Documentation/hwmon/{ltc4215 =3D> ltc4215.rst}  |   0
> >  Documentation/hwmon/{ltc4245 =3D> ltc4245.rst}  |   0
> >  Documentation/hwmon/{ltc4260 =3D> ltc4260.rst}  |   0
> >  Documentation/hwmon/{ltc4261 =3D> ltc4261.rst}  |   0
> >  .../hwmon/{max16064 =3D> max16064.rst}          |   2 +-
> >  .../hwmon/{max16065 =3D> max16065.rst}          |   0
> >  Documentation/hwmon/{max1619 =3D> max1619.rst}  |   1 -
> >  Documentation/hwmon/{max1668 =3D> max1668.rst}  |   0
> >  Documentation/hwmon/{max197 =3D> max197.rst}    |   0
> >  .../hwmon/{max20751 =3D> max20751.rst}          |   2 +-
> >  .../hwmon/{max31722 =3D> max31722.rst}          |   0
> >  .../hwmon/{max31785 =3D> max31785.rst}          |   0
> >  .../hwmon/{max31790 =3D> max31790.rst}          |   0
> >  .../hwmon/{max34440 =3D> max34440.rst}          |   2 +-
> >  Documentation/hwmon/{max6639 =3D> max6639.rst}  |   0
> >  Documentation/hwmon/{max6642 =3D> max6642.rst}  |   0
> >  Documentation/hwmon/{max6650 =3D> max6650.rst}  |   1 -
> >  Documentation/hwmon/{max6697 =3D> max6697.rst}  |   0
> >  Documentation/hwmon/{max8688 =3D> max8688.rst}  |   2 +-
> >  .../hwmon/{mc13783-adc =3D> mc13783-adc.rst}    |   0
> >  Documentation/hwmon/{mcp3021 =3D> mcp3021.rst}  |   0
> >  .../hwmon/{menf21bmc =3D> menf21bmc.rst}        |   0
> >  .../hwmon/{mlxreg-fan =3D> mlxreg-fan.rst}      |   0
> >  Documentation/hwmon/{nct6683 =3D> nct6683.rst}  |   0
> >  Documentation/hwmon/{nct6775 =3D> nct6775.rst}  |   0
> >  Documentation/hwmon/{nct7802 =3D> nct7802.rst}  |   0
> >  Documentation/hwmon/{nct7904 =3D> nct7904.rst}  |   0
> >  .../{npcm750-pwm-fan =3D> npcm750-pwm-fan.rst}  |   0
> >  Documentation/hwmon/{nsa320 =3D> nsa320.rst}    |   0
> >  .../{ntc_thermistor =3D> ntc_thermistor.rst}    |   0
> >  Documentation/hwmon/{occ =3D> occ.rst}          |   0
> >  Documentation/hwmon/{pc87360 =3D> pc87360.rst}  |   0
> >  Documentation/hwmon/{pc87427 =3D> pc87427.rst}  |   0
> >  Documentation/hwmon/{pcf8591 =3D> pcf8591.rst}  |   0
> >  .../hwmon/{pmbus-core =3D> pmbus-core.rst}      |   0
> >  Documentation/hwmon/{pmbus =3D> pmbus.rst}      |   0
> >  .../hwmon/{powr1220 =3D> powr1220.rst}          |   0
> >  Documentation/hwmon/{pwm-fan =3D> pwm-fan.rst}  |   0
> >  ...aspberrypi-hwmon =3D> raspberrypi-hwmon.rst} |   0
> >  Documentation/hwmon/{sch5627 =3D> sch5627.rst}  |   0
> >  Documentation/hwmon/{sch5636 =3D> sch5636.rst}  |   0
> >  .../hwmon/{scpi-hwmon =3D> scpi-hwmon.rst}      |   0
> >  Documentation/hwmon/{sht15 =3D> sht15.rst}      |   0
> >  Documentation/hwmon/{sht21 =3D> sht21.rst}      |   0
> >  Documentation/hwmon/{sht3x =3D> sht3x.rst}      |   0
> >  Documentation/hwmon/{shtc1 =3D> shtc1.rst}      |   0
> >  Documentation/hwmon/{sis5595 =3D> sis5595.rst}  |   1 -
> >  Documentation/hwmon/{smm665 =3D> smm665.rst}    |   0
> >  .../hwmon/{smsc47b397 =3D> smsc47b397.rst}      |   0
> >  .../hwmon/{smsc47m1 =3D> smsc47m1.rst}          |   0
> >  .../hwmon/{smsc47m192 =3D> smsc47m192.rst}      |   0
> >  ...mitting-patches =3D> submitting-patches.rst} |   6 +-
> >  .../{sysfs-interface =3D> sysfs-interface.rst}  |   0
> >  Documentation/hwmon/{tc654 =3D> tc654.rst}      |   0
> >  Documentation/hwmon/{tc74 =3D> tc74.rst}        |   0
> >  Documentation/hwmon/{thmc50 =3D> thmc50.rst}    |   1 -
> >  Documentation/hwmon/{tmp102 =3D> tmp102.rst}    |   2 +-
> >  Documentation/hwmon/{tmp103 =3D> tmp103.rst}    |   2 +-
> >  Documentation/hwmon/{tmp108 =3D> tmp108.rst}    |   2 +-
> >  Documentation/hwmon/{tmp401 =3D> tmp401.rst}    |   2 +-
> >  Documentation/hwmon/{tmp421 =3D> tmp421.rst}    |   0
> >  .../hwmon/{tps40422 =3D> tps40422.rst}          |   2 +-
> >  ...4030-madc-hwmon =3D> twl4030-madc-hwmon.rst} |   0
> >  Documentation/hwmon/{ucd9000 =3D> ucd9000.rst}  |   4 +-
> >  Documentation/hwmon/{ucd9200 =3D> ucd9200.rst}  |   4 +-
> >  .../{userspace-tools =3D> userspace-tools.rst}  |   0
> >  .../hwmon/{vexpress =3D> vexpress.rst}          |   0
> >  Documentation/hwmon/{via686a =3D> via686a.rst}  |   0
> >  Documentation/hwmon/{vt1211 =3D> vt1211.rst}    |   0
> >  .../hwmon/{w83627ehf =3D> w83627ehf.rst}        |   0
> >  .../hwmon/{w83627hf =3D> w83627hf.rst}          |   0
> >  Documentation/hwmon/{w83773g =3D> w83773g.rst}  |   0
> >  Documentation/hwmon/{w83781d =3D> w83781d.rst}  |   0
> >  Documentation/hwmon/{w83791d =3D> w83791d.rst}  |   2 +-
> >  Documentation/hwmon/{w83792d =3D> w83792d.rst}  |   0
> >  Documentation/hwmon/{w83793 =3D> w83793.rst}    |   0
> >  Documentation/hwmon/{w83795 =3D> w83795.rst}    |   0
> >  .../hwmon/{w83l785ts =3D> w83l785ts.rst}        |   0
> >  .../hwmon/{w83l786ng =3D> w83l786ng.rst}        |   0
> >  Documentation/hwmon/{wm831x =3D> wm831x.rst}    |   0
> >  Documentation/hwmon/{wm8350 =3D> wm8350.rst}    |   0
> >  .../hwmon/{xgene-hwmon =3D> xgene-hwmon.rst}    |   0
> >  Documentation/hwmon/{zl6100 =3D> zl6100.rst}    |   2 +-
> >  Documentation/index.rst                       |   1 +
> >  Documentation/thermal/sysfs-api.txt           |   2 +-
> >  MAINTAINERS                                   | 108 +++++------
> >  drivers/hwmon/Kconfig                         |   8 +-
> >  drivers/hwmon/ads7828.c                       |   2 +-
> >  drivers/hwmon/max197.c                        |   2 +-
> >  drivers/hwmon/sht15.c                         |   2 +-
> >  include/linux/platform_data/ads7828.h         |   2 +-
> >  include/linux/platform_data/ds620.h           |   2 +-
> >  include/linux/platform_data/ina2xx.h          |   2 +-
> >  include/linux/platform_data/max197.h          |   2 +-
> >  include/linux/platform_data/ntc_thermistor.h  |   2 +-
> >  173 files changed, 275 insertions(+), 102 deletions(-)
> >  rename Documentation/hwmon/{ab8500 =3D> ab8500.rst} (86%)
> >  rename Documentation/hwmon/{abituguru-datasheet =3D> abituguru-datashe=
et.rst} (100%)
> >  rename Documentation/hwmon/{abituguru =3D> abituguru.rst} (100%)
> >  rename Documentation/hwmon/{abituguru3 =3D> abituguru3.rst} (100%)
> >  rename Documentation/hwmon/{abx500 =3D> abx500.rst} (100%)
> >  rename Documentation/hwmon/{acpi_power_meter =3D> acpi_power_meter.rst=
} (97%)
> >  rename Documentation/hwmon/{ad7314 =3D> ad7314.rst} (100%)
> >  rename Documentation/hwmon/{adc128d818 =3D> adc128d818.rst} (100%)
> >  rename Documentation/hwmon/{adm1021 =3D> adm1021.rst} (100%)
> >  rename Documentation/hwmon/{adm1025 =3D> adm1025.rst} (100%)
> >  rename Documentation/hwmon/{adm1026 =3D> adm1026.rst} (100%)
> >  rename Documentation/hwmon/{adm1031 =3D> adm1031.rst} (100%)
> >  rename Documentation/hwmon/{adm1275 =3D> adm1275.rst} (97%)
> >  rename Documentation/hwmon/{adm9240 =3D> adm9240.rst} (100%)
> >  rename Documentation/hwmon/{ads1015 =3D> ads1015.rst} (100%)
> >  rename Documentation/hwmon/{ads7828 =3D> ads7828.rst} (100%)
> >  rename Documentation/hwmon/{adt7410 =3D> adt7410.rst} (100%)
> >  rename Documentation/hwmon/{adt7411 =3D> adt7411.rst} (100%)
> >  rename Documentation/hwmon/{adt7462 =3D> adt7462.rst} (99%)
> >  rename Documentation/hwmon/{adt7470 =3D> adt7470.rst} (100%)
> >  rename Documentation/hwmon/{adt7475 =3D> adt7475.rst} (100%)
> >  rename Documentation/hwmon/{amc6821 =3D> amc6821.rst} (99%)
> >  rename Documentation/hwmon/{asb100 =3D> asb100.rst} (99%)
> >  rename Documentation/hwmon/{asc7621 =3D> asc7621.rst} (100%)
> >  rename Documentation/hwmon/{aspeed-pwm-tacho =3D> aspeed-pwm-tacho.rst=
} (100%)
> >  rename Documentation/hwmon/{coretemp =3D> coretemp.rst} (100%)
> >  rename Documentation/hwmon/{da9052 =3D> da9052.rst} (100%)
> >  rename Documentation/hwmon/{da9055 =3D> da9055.rst} (100%)
> >  rename Documentation/hwmon/{dme1737 =3D> dme1737.rst} (100%)
> >  rename Documentation/hwmon/{ds1621 =3D> ds1621.rst} (100%)
> >  rename Documentation/hwmon/{ds620 =3D> ds620.rst} (100%)
> >  rename Documentation/hwmon/{emc1403 =3D> emc1403.rst} (100%)
> >  rename Documentation/hwmon/{emc2103 =3D> emc2103.rst} (100%)
> >  rename Documentation/hwmon/{emc6w201 =3D> emc6w201.rst} (100%)
> >  rename Documentation/hwmon/{f71805f =3D> f71805f.rst} (100%)
> >  rename Documentation/hwmon/{f71882fg =3D> f71882fg.rst} (100%)
> >  rename Documentation/hwmon/{fam15h_power =3D> fam15h_power.rst} (100%)
> >  rename Documentation/hwmon/{ftsteutates =3D> ftsteutates.rst} (100%)
> >  rename Documentation/hwmon/{g760a =3D> g760a.rst} (100%)
> >  rename Documentation/hwmon/{g762 =3D> g762.rst} (97%)
> >  rename Documentation/hwmon/{gl518sm =3D> gl518sm.rst} (100%)
> >  rename Documentation/hwmon/{hih6130 =3D> hih6130.rst} (100%)
> >  rename Documentation/hwmon/{hwmon-kernel-api.txt =3D> hwmon-kernel-api=
.rst} (99%)
> >  rename Documentation/hwmon/{ibm-cffps =3D> ibm-cffps.rst} (100%)
> >  rename Documentation/hwmon/{ibmaem =3D> ibmaem.rst} (100%)
> >  rename Documentation/hwmon/{ibmpowernv =3D> ibmpowernv.rst} (100%)
> >  rename Documentation/hwmon/{ina209 =3D> ina209.rst} (100%)
> >  rename Documentation/hwmon/{ina2xx =3D> ina2xx.rst} (97%)
> >  rename Documentation/hwmon/{ina3221 =3D> ina3221.rst} (100%)
> >  create mode 100644 Documentation/hwmon/index.rst
> >  rename Documentation/hwmon/{ir35221 =3D> ir35221.rst} (100%)
> >  rename Documentation/hwmon/{it87 =3D> it87.rst} (100%)
> >  rename Documentation/hwmon/{jc42 =3D> jc42.rst} (100%)
> >  rename Documentation/hwmon/{k10temp =3D> k10temp.rst} (100%)
> >  rename Documentation/hwmon/{k8temp =3D> k8temp.rst} (100%)
> >  rename Documentation/hwmon/{lineage-pem =3D> lineage-pem.rst} (100%)
> >  rename Documentation/hwmon/{lm25066 =3D> lm25066.rst} (97%)
> >  rename Documentation/hwmon/{lm63 =3D> lm63.rst} (100%)
> >  rename Documentation/hwmon/{lm70 =3D> lm70.rst} (100%)
> >  rename Documentation/hwmon/{lm73 =3D> lm73.rst} (100%)
> >  rename Documentation/hwmon/{lm75 =3D> lm75.rst} (100%)
> >  rename Documentation/hwmon/{lm77 =3D> lm77.rst} (100%)
> >  rename Documentation/hwmon/{lm78 =3D> lm78.rst} (100%)
> >  rename Documentation/hwmon/{lm80 =3D> lm80.rst} (100%)
> >  rename Documentation/hwmon/{lm83 =3D> lm83.rst} (100%)
> >  rename Documentation/hwmon/{lm85 =3D> lm85.rst} (100%)
> >  rename Documentation/hwmon/{lm87 =3D> lm87.rst} (100%)
> >  rename Documentation/hwmon/{lm90 =3D> lm90.rst} (100%)
> >  rename Documentation/hwmon/{lm92 =3D> lm92.rst} (100%)
> >  rename Documentation/hwmon/{lm93 =3D> lm93.rst} (100%)
> >  rename Documentation/hwmon/{lm95234 =3D> lm95234.rst} (100%)
> >  rename Documentation/hwmon/{lm95245 =3D> lm95245.rst} (100%)
> >  rename Documentation/hwmon/{ltc2945 =3D> ltc2945.rst} (100%)
> >  rename Documentation/hwmon/{ltc2978 =3D> ltc2978.rst} (100%)
> >  rename Documentation/hwmon/{ltc2990 =3D> ltc2990.rst} (100%)
> >  rename Documentation/hwmon/{ltc3815 =3D> ltc3815.rst} (100%)
> >  rename Documentation/hwmon/{ltc4151 =3D> ltc4151.rst} (100%)
> >  rename Documentation/hwmon/{ltc4215 =3D> ltc4215.rst} (100%)
> >  rename Documentation/hwmon/{ltc4245 =3D> ltc4245.rst} (100%)
> >  rename Documentation/hwmon/{ltc4260 =3D> ltc4260.rst} (100%)
> >  rename Documentation/hwmon/{ltc4261 =3D> ltc4261.rst} (100%)
> >  rename Documentation/hwmon/{max16064 =3D> max16064.rst} (96%)
> >  rename Documentation/hwmon/{max16065 =3D> max16065.rst} (100%)
> >  rename Documentation/hwmon/{max1619 =3D> max1619.rst} (99%)
> >  rename Documentation/hwmon/{max1668 =3D> max1668.rst} (100%)
> >  rename Documentation/hwmon/{max197 =3D> max197.rst} (100%)
> >  rename Documentation/hwmon/{max20751 =3D> max20751.rst} (96%)
> >  rename Documentation/hwmon/{max31722 =3D> max31722.rst} (100%)
> >  rename Documentation/hwmon/{max31785 =3D> max31785.rst} (100%)
> >  rename Documentation/hwmon/{max31790 =3D> max31790.rst} (100%)
> >  rename Documentation/hwmon/{max34440 =3D> max34440.rst} (98%)
> >  rename Documentation/hwmon/{max6639 =3D> max6639.rst} (100%)
> >  rename Documentation/hwmon/{max6642 =3D> max6642.rst} (100%)
> >  rename Documentation/hwmon/{max6650 =3D> max6650.rst} (99%)
> >  rename Documentation/hwmon/{max6697 =3D> max6697.rst} (100%)
> >  rename Documentation/hwmon/{max8688 =3D> max8688.rst} (97%)
> >  rename Documentation/hwmon/{mc13783-adc =3D> mc13783-adc.rst} (100%)
> >  rename Documentation/hwmon/{mcp3021 =3D> mcp3021.rst} (100%)
> >  rename Documentation/hwmon/{menf21bmc =3D> menf21bmc.rst} (100%)
> >  rename Documentation/hwmon/{mlxreg-fan =3D> mlxreg-fan.rst} (100%)
> >  rename Documentation/hwmon/{nct6683 =3D> nct6683.rst} (100%)
> >  rename Documentation/hwmon/{nct6775 =3D> nct6775.rst} (100%)
> >  rename Documentation/hwmon/{nct7802 =3D> nct7802.rst} (100%)
> >  rename Documentation/hwmon/{nct7904 =3D> nct7904.rst} (100%)
> >  rename Documentation/hwmon/{npcm750-pwm-fan =3D> npcm750-pwm-fan.rst} =
(100%)
> >  rename Documentation/hwmon/{nsa320 =3D> nsa320.rst} (100%)
> >  rename Documentation/hwmon/{ntc_thermistor =3D> ntc_thermistor.rst} (1=
00%)
> >  rename Documentation/hwmon/{occ =3D> occ.rst} (100%)
> >  rename Documentation/hwmon/{pc87360 =3D> pc87360.rst} (100%)
> >  rename Documentation/hwmon/{pc87427 =3D> pc87427.rst} (100%)
> >  rename Documentation/hwmon/{pcf8591 =3D> pcf8591.rst} (100%)
> >  rename Documentation/hwmon/{pmbus-core =3D> pmbus-core.rst} (100%)
> >  rename Documentation/hwmon/{pmbus =3D> pmbus.rst} (100%)
> >  rename Documentation/hwmon/{powr1220 =3D> powr1220.rst} (100%)
> >  rename Documentation/hwmon/{pwm-fan =3D> pwm-fan.rst} (100%)
> >  rename Documentation/hwmon/{raspberrypi-hwmon =3D> raspberrypi-hwmon.r=
st} (100%)
> >  rename Documentation/hwmon/{sch5627 =3D> sch5627.rst} (100%)
> >  rename Documentation/hwmon/{sch5636 =3D> sch5636.rst} (100%)
> >  rename Documentation/hwmon/{scpi-hwmon =3D> scpi-hwmon.rst} (100%)
> >  rename Documentation/hwmon/{sht15 =3D> sht15.rst} (100%)
> >  rename Documentation/hwmon/{sht21 =3D> sht21.rst} (100%)
> >  rename Documentation/hwmon/{sht3x =3D> sht3x.rst} (100%)
> >  rename Documentation/hwmon/{shtc1 =3D> shtc1.rst} (100%)
> >  rename Documentation/hwmon/{sis5595 =3D> sis5595.rst} (99%)
> >  rename Documentation/hwmon/{smm665 =3D> smm665.rst} (100%)
> >  rename Documentation/hwmon/{smsc47b397 =3D> smsc47b397.rst} (100%)
> >  rename Documentation/hwmon/{smsc47m1 =3D> smsc47m1.rst} (100%)
> >  rename Documentation/hwmon/{smsc47m192 =3D> smsc47m192.rst} (100%)
> >  rename Documentation/hwmon/{submitting-patches =3D> submitting-patches=
.rst} (98%)
> >  rename Documentation/hwmon/{sysfs-interface =3D> sysfs-interface.rst} =
(100%)
> >  rename Documentation/hwmon/{tc654 =3D> tc654.rst} (100%)
> >  rename Documentation/hwmon/{tc74 =3D> tc74.rst} (100%)
> >  rename Documentation/hwmon/{thmc50 =3D> thmc50.rst} (99%)
> >  rename Documentation/hwmon/{tmp102 =3D> tmp102.rst} (93%)
> >  rename Documentation/hwmon/{tmp103 =3D> tmp103.rst} (92%)
> >  rename Documentation/hwmon/{tmp108 =3D> tmp108.rst} (95%)
> >  rename Documentation/hwmon/{tmp401 =3D> tmp401.rst} (97%)
> >  rename Documentation/hwmon/{tmp421 =3D> tmp421.rst} (100%)
> >  rename Documentation/hwmon/{tps40422 =3D> tps40422.rst} (96%)
> >  rename Documentation/hwmon/{twl4030-madc-hwmon =3D> twl4030-madc-hwmon=
.rst} (100%)
> >  rename Documentation/hwmon/{ucd9000 =3D> ucd9000.rst} (97%)
> >  rename Documentation/hwmon/{ucd9200 =3D> ucd9200.rst} (97%)
> >  rename Documentation/hwmon/{userspace-tools =3D> userspace-tools.rst} =
(100%)
> >  rename Documentation/hwmon/{vexpress =3D> vexpress.rst} (100%)
> >  rename Documentation/hwmon/{via686a =3D> via686a.rst} (100%)
> >  rename Documentation/hwmon/{vt1211 =3D> vt1211.rst} (100%)
> >  rename Documentation/hwmon/{w83627ehf =3D> w83627ehf.rst} (100%)
> >  rename Documentation/hwmon/{w83627hf =3D> w83627hf.rst} (100%)
> >  rename Documentation/hwmon/{w83773g =3D> w83773g.rst} (100%)
> >  rename Documentation/hwmon/{w83781d =3D> w83781d.rst} (100%)
> >  rename Documentation/hwmon/{w83791d =3D> w83791d.rst} (99%)
> >  rename Documentation/hwmon/{w83792d =3D> w83792d.rst} (100%)
> >  rename Documentation/hwmon/{w83793 =3D> w83793.rst} (100%)
> >  rename Documentation/hwmon/{w83795 =3D> w83795.rst} (100%)
> >  rename Documentation/hwmon/{w83l785ts =3D> w83l785ts.rst} (100%)
> >  rename Documentation/hwmon/{w83l786ng =3D> w83l786ng.rst} (100%)
> >  rename Documentation/hwmon/{wm831x =3D> wm831x.rst} (100%)
> >  rename Documentation/hwmon/{wm8350 =3D> wm8350.rst} (100%)
> >  rename Documentation/hwmon/{xgene-hwmon =3D> xgene-hwmon.rst} (100%)
> >  rename Documentation/hwmon/{zl6100 =3D> zl6100.rst} (98%)
> >=20
> > diff --git a/Documentation/devicetree/bindings/hwmon/g762.txt b/Documen=
tation/devicetree/bindings/hwmon/g762.txt
> > index 25cc6d8ee575..6d154c4923de 100644
> > --- a/Documentation/devicetree/bindings/hwmon/g762.txt
> > +++ b/Documentation/devicetree/bindings/hwmon/g762.txt
> > @@ -21,7 +21,7 @@ If an optional property is not set in .dts file, then=
 current value is kept
> >  unmodified (e.g. u-boot installed value).
> > =20
> >  Additional information on operational parameters for the device is ava=
ilable
> > -in Documentation/hwmon/g762. A detailed datasheet for the device is av=
ailable
> > +in Documentation/hwmon/g762.rst. A detailed datasheet for the device i=
s available
> >  at http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf.
> > =20
> >  Example g762 node:
> > diff --git a/Documentation/hwmon/ab8500 b/Documentation/hwmon/ab8500.rst
> > similarity index 86%
> > rename from Documentation/hwmon/ab8500
> > rename to Documentation/hwmon/ab8500.rst
> > index d87c61151239..33f93a9cec04 100644
> > --- a/Documentation/hwmon/ab8500
> > +++ b/Documentation/hwmon/ab8500.rst
> > @@ -18,7 +18,7 @@ Authors:
> >  Description
> >  -----------
> > =20
> > -See also Documentation/hwmon/abx500. This is the ST-Ericsson AB8500 sp=
ecific
> > +See also Documentation/hwmon/abx500.rst. This is the ST-Ericsson AB850=
0 specific
> >  driver.
> > =20
> >  Currently only the AB8500 internal sensor and one external sensor for =
battery
> > diff --git a/Documentation/hwmon/abituguru-datasheet b/Documentation/hw=
mon/abituguru-datasheet.rst
> > similarity index 100%
> > rename from Documentation/hwmon/abituguru-datasheet
> > rename to Documentation/hwmon/abituguru-datasheet.rst
> > diff --git a/Documentation/hwmon/abituguru b/Documentation/hwmon/abitug=
uru.rst
> > similarity index 100%
> > rename from Documentation/hwmon/abituguru
> > rename to Documentation/hwmon/abituguru.rst
> > diff --git a/Documentation/hwmon/abituguru3 b/Documentation/hwmon/abitu=
guru3.rst
> > similarity index 100%
> > rename from Documentation/hwmon/abituguru3
> > rename to Documentation/hwmon/abituguru3.rst
> > diff --git a/Documentation/hwmon/abx500 b/Documentation/hwmon/abx500.rst
> > similarity index 100%
> > rename from Documentation/hwmon/abx500
> > rename to Documentation/hwmon/abx500.rst
> > diff --git a/Documentation/hwmon/acpi_power_meter b/Documentation/hwmon=
/acpi_power_meter.rst
> > similarity index 97%
> > rename from Documentation/hwmon/acpi_power_meter
> > rename to Documentation/hwmon/acpi_power_meter.rst
> > index 7665ca6ba957..4a0941ade0ca 100644
> > --- a/Documentation/hwmon/acpi_power_meter
> > +++ b/Documentation/hwmon/acpi_power_meter.rst
> > @@ -21,7 +21,7 @@ the ACPI 4.0 spec (Chapter 10.4).  These devices have=
 a simple set of
> >  features--a power meter that returns average power use over a configur=
able
> >  interval, an optional capping mechanism, and a couple of trip points. =
 The
> >  sysfs interface conforms with the specification outlined in the "Power=
" section
> > -of Documentation/hwmon/sysfs-interface.
> > +of Documentation/hwmon/sysfs-interface.rst.
> > =20
> >  Special Features
> >  ----------------
> > diff --git a/Documentation/hwmon/ad7314 b/Documentation/hwmon/ad7314.rst
> > similarity index 100%
> > rename from Documentation/hwmon/ad7314
> > rename to Documentation/hwmon/ad7314.rst
> > diff --git a/Documentation/hwmon/adc128d818 b/Documentation/hwmon/adc12=
8d818.rst
> > similarity index 100%
> > rename from Documentation/hwmon/adc128d818
> > rename to Documentation/hwmon/adc128d818.rst
> > diff --git a/Documentation/hwmon/adm1021 b/Documentation/hwmon/adm1021.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/adm1021
> > rename to Documentation/hwmon/adm1021.rst
> > diff --git a/Documentation/hwmon/adm1025 b/Documentation/hwmon/adm1025.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/adm1025
> > rename to Documentation/hwmon/adm1025.rst
> > diff --git a/Documentation/hwmon/adm1026 b/Documentation/hwmon/adm1026.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/adm1026
> > rename to Documentation/hwmon/adm1026.rst
> > diff --git a/Documentation/hwmon/adm1031 b/Documentation/hwmon/adm1031.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/adm1031
> > rename to Documentation/hwmon/adm1031.rst
> > diff --git a/Documentation/hwmon/adm1275 b/Documentation/hwmon/adm1275.=
rst
> > similarity index 97%
> > rename from Documentation/hwmon/adm1275
> > rename to Documentation/hwmon/adm1275.rst
> > index 5c5860011d6e..9a1913e5b4d9 100644
> > --- a/Documentation/hwmon/adm1275
> > +++ b/Documentation/hwmon/adm1275.rst
> > @@ -68,7 +68,7 @@ integrated 12 bit analog-to-digital converter (ADC), =
accessed using a
> >  PMBus interface.
> > =20
> >  The driver is a client driver to the core PMBus driver. Please see
> > -Documentation/hwmon/pmbus for details on PMBus client drivers.
> > +Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> > =20
> > =20
> >  Usage Notes
> > @@ -90,7 +90,7 @@ Platform data support
> >  ---------------------
> > =20
> >  The driver supports standard PMBus driver platform data. Please see
> > -Documentation/hwmon/pmbus for details.
> > +Documentation/hwmon/pmbus.rst for details.
> > =20
> > =20
> >  Sysfs entries
> > diff --git a/Documentation/hwmon/adm9240 b/Documentation/hwmon/adm9240.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/adm9240
> > rename to Documentation/hwmon/adm9240.rst
> > diff --git a/Documentation/hwmon/ads1015 b/Documentation/hwmon/ads1015.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/ads1015
> > rename to Documentation/hwmon/ads1015.rst
> > diff --git a/Documentation/hwmon/ads7828 b/Documentation/hwmon/ads7828.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/ads7828
> > rename to Documentation/hwmon/ads7828.rst
> > diff --git a/Documentation/hwmon/adt7410 b/Documentation/hwmon/adt7410.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/adt7410
> > rename to Documentation/hwmon/adt7410.rst
> > diff --git a/Documentation/hwmon/adt7411 b/Documentation/hwmon/adt7411.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/adt7411
> > rename to Documentation/hwmon/adt7411.rst
> > diff --git a/Documentation/hwmon/adt7462 b/Documentation/hwmon/adt7462.=
rst
> > similarity index 99%
> > rename from Documentation/hwmon/adt7462
> > rename to Documentation/hwmon/adt7462.rst
> > index a7a831118d32..139e19696188 100644
> > --- a/Documentation/hwmon/adt7462
> > +++ b/Documentation/hwmon/adt7462.rst
> > @@ -68,4 +68,3 @@ The ADT7462 will scale the pwm between the lower and =
higher pwm speed when
> >  the temperature is between the two temperature boundaries.  PWM values=
 range
> >  from 0 (off) to 255 (full speed).  Fan speed will be set to maximum wh=
en the
> >  temperature sensor associated with the PWM control exceeds temp#_max.
> > -
> > diff --git a/Documentation/hwmon/adt7470 b/Documentation/hwmon/adt7470.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/adt7470
> > rename to Documentation/hwmon/adt7470.rst
> > diff --git a/Documentation/hwmon/adt7475 b/Documentation/hwmon/adt7475.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/adt7475
> > rename to Documentation/hwmon/adt7475.rst
> > diff --git a/Documentation/hwmon/amc6821 b/Documentation/hwmon/amc6821.=
rst
> > similarity index 99%
> > rename from Documentation/hwmon/amc6821
> > rename to Documentation/hwmon/amc6821.rst
> > index d10eabcbc0f3..5ddb2849da90 100644
> > --- a/Documentation/hwmon/amc6821
> > +++ b/Documentation/hwmon/amc6821.rst
> > @@ -106,4 +106,3 @@ different settings, you can set the following param=
eters:
> > =20
> >  - init=3D1,
> >  - pwminv: 0 default pwm output, 1 inverts pwm output.
> > -
> > diff --git a/Documentation/hwmon/asb100 b/Documentation/hwmon/asb100.rst
> > similarity index 99%
> > rename from Documentation/hwmon/asb100
> > rename to Documentation/hwmon/asb100.rst
> > index 311d9f7b6926..c2d5f97085fe 100644
> > --- a/Documentation/hwmon/asb100
> > +++ b/Documentation/hwmon/asb100.rst
> > @@ -71,4 +71,3 @@ TODO:
> >    * Experiment with temp. sensor types.
> >    * Are there really 13 voltage inputs? Probably not...
> >    * Cleanups, no doubt...
> > -
> > diff --git a/Documentation/hwmon/asc7621 b/Documentation/hwmon/asc7621.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/asc7621
> > rename to Documentation/hwmon/asc7621.rst
> > diff --git a/Documentation/hwmon/aspeed-pwm-tacho b/Documentation/hwmon=
/aspeed-pwm-tacho.rst
> > similarity index 100%
> > rename from Documentation/hwmon/aspeed-pwm-tacho
> > rename to Documentation/hwmon/aspeed-pwm-tacho.rst
> > diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretem=
p.rst
> > similarity index 100%
> > rename from Documentation/hwmon/coretemp
> > rename to Documentation/hwmon/coretemp.rst
> > diff --git a/Documentation/hwmon/da9052 b/Documentation/hwmon/da9052.rst
> > similarity index 100%
> > rename from Documentation/hwmon/da9052
> > rename to Documentation/hwmon/da9052.rst
> > diff --git a/Documentation/hwmon/da9055 b/Documentation/hwmon/da9055.rst
> > similarity index 100%
> > rename from Documentation/hwmon/da9055
> > rename to Documentation/hwmon/da9055.rst
> > diff --git a/Documentation/hwmon/dme1737 b/Documentation/hwmon/dme1737.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/dme1737
> > rename to Documentation/hwmon/dme1737.rst
> > diff --git a/Documentation/hwmon/ds1621 b/Documentation/hwmon/ds1621.rst
> > similarity index 100%
> > rename from Documentation/hwmon/ds1621
> > rename to Documentation/hwmon/ds1621.rst
> > diff --git a/Documentation/hwmon/ds620 b/Documentation/hwmon/ds620.rst
> > similarity index 100%
> > rename from Documentation/hwmon/ds620
> > rename to Documentation/hwmon/ds620.rst
> > diff --git a/Documentation/hwmon/emc1403 b/Documentation/hwmon/emc1403.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/emc1403
> > rename to Documentation/hwmon/emc1403.rst
> > diff --git a/Documentation/hwmon/emc2103 b/Documentation/hwmon/emc2103.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/emc2103
> > rename to Documentation/hwmon/emc2103.rst
> > diff --git a/Documentation/hwmon/emc6w201 b/Documentation/hwmon/emc6w20=
1.rst
> > similarity index 100%
> > rename from Documentation/hwmon/emc6w201
> > rename to Documentation/hwmon/emc6w201.rst
> > diff --git a/Documentation/hwmon/f71805f b/Documentation/hwmon/f71805f.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/f71805f
> > rename to Documentation/hwmon/f71805f.rst
> > diff --git a/Documentation/hwmon/f71882fg b/Documentation/hwmon/f71882f=
g.rst
> > similarity index 100%
> > rename from Documentation/hwmon/f71882fg
> > rename to Documentation/hwmon/f71882fg.rst
> > diff --git a/Documentation/hwmon/fam15h_power b/Documentation/hwmon/fam=
15h_power.rst
> > similarity index 100%
> > rename from Documentation/hwmon/fam15h_power
> > rename to Documentation/hwmon/fam15h_power.rst
> > diff --git a/Documentation/hwmon/ftsteutates b/Documentation/hwmon/ftst=
eutates.rst
> > similarity index 100%
> > rename from Documentation/hwmon/ftsteutates
> > rename to Documentation/hwmon/ftsteutates.rst
> > diff --git a/Documentation/hwmon/g760a b/Documentation/hwmon/g760a.rst
> > similarity index 100%
> > rename from Documentation/hwmon/g760a
> > rename to Documentation/hwmon/g760a.rst
> > diff --git a/Documentation/hwmon/g762 b/Documentation/hwmon/g762.rst
> > similarity index 97%
> > rename from Documentation/hwmon/g762
> > rename to Documentation/hwmon/g762.rst
> > index 54574e26df21..0371b3365c48 100644
> > --- a/Documentation/hwmon/g762
> > +++ b/Documentation/hwmon/g762.rst
> > @@ -7,7 +7,7 @@ modes - PWM or DC - are supported by the device.
> > =20
> >  For additional information, a detailed datasheet is available at
> >  http://natisbad.org/NAS/ref/GMT_EDS-762_763-080710-0.2.pdf. sysfs
> > -bindings are described in Documentation/hwmon/sysfs-interface.
> > +bindings are described in Documentation/hwmon/sysfs-interface.rst.
> > =20
> >  The following entries are available to the user in a subdirectory of
> >  /sys/bus/i2c/drivers/g762/ to control the operation of the device.
> > diff --git a/Documentation/hwmon/gl518sm b/Documentation/hwmon/gl518sm.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/gl518sm
> > rename to Documentation/hwmon/gl518sm.rst
> > diff --git a/Documentation/hwmon/hih6130 b/Documentation/hwmon/hih6130.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/hih6130
> > rename to Documentation/hwmon/hih6130.rst
> > diff --git a/Documentation/hwmon/hwmon-kernel-api.txt b/Documentation/h=
wmon/hwmon-kernel-api.rst
> > similarity index 99%
> > rename from Documentation/hwmon/hwmon-kernel-api.txt
> > rename to Documentation/hwmon/hwmon-kernel-api.rst
> > index b347b959fcda..c41eb6108103 100644
> > --- a/Documentation/hwmon/hwmon-kernel-api.txt
> > +++ b/Documentation/hwmon/hwmon-kernel-api.rst
> > @@ -12,10 +12,10 @@ drivers that want to use the hardware monitoring fr=
amework.
> >  This document does not describe what a hardware monitoring (hwmon) Dri=
ver or
> >  Device is. It also does not describe the API which can be used by user=
 space
> >  to communicate with a hardware monitoring device. If you want to know =
this
> > -then please read the following file: Documentation/hwmon/sysfs-interfa=
ce.
> > +then please read the following file: Documentation/hwmon/sysfs-interfa=
ce.rst.
> > =20
> >  For additional guidelines on how to write and improve hwmon drivers, p=
lease
> > -also read Documentation/hwmon/submitting-patches.
> > +also read Documentation/hwmon/submitting-patches.rst.
> > =20
> >  The API
> >  -------
> > diff --git a/Documentation/hwmon/ibm-cffps b/Documentation/hwmon/ibm-cf=
fps.rst
> > similarity index 100%
> > rename from Documentation/hwmon/ibm-cffps
> > rename to Documentation/hwmon/ibm-cffps.rst
> > diff --git a/Documentation/hwmon/ibmaem b/Documentation/hwmon/ibmaem.rst
> > similarity index 100%
> > rename from Documentation/hwmon/ibmaem
> > rename to Documentation/hwmon/ibmaem.rst
> > diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpo=
wernv.rst
> > similarity index 100%
> > rename from Documentation/hwmon/ibmpowernv
> > rename to Documentation/hwmon/ibmpowernv.rst
> > diff --git a/Documentation/hwmon/ina209 b/Documentation/hwmon/ina209.rst
> > similarity index 100%
> > rename from Documentation/hwmon/ina209
> > rename to Documentation/hwmon/ina209.rst
> > diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx.rst
> > similarity index 97%
> > rename from Documentation/hwmon/ina2xx
> > rename to Documentation/hwmon/ina2xx.rst
> > index 95badf9c396f..94b9a260c518 100644
> > --- a/Documentation/hwmon/ina2xx
> > +++ b/Documentation/hwmon/ina2xx.rst
> > @@ -78,7 +78,7 @@ refer to the Documentation/devicetree/bindings/hwmon/=
ina2xx.txt for bindings
> >  if the device tree is used.
> > =20
> >  Additionally ina226 supports update_interval attribute as described in
> > -Documentation/hwmon/sysfs-interface. Internally the interval is the su=
m of
> > +Documentation/hwmon/sysfs-interface.rst. Internally the interval is th=
e sum of
> >  bus and shunt voltage conversion times multiplied by the averaging rat=
e. We
> >  don't touch the conversion times and only modify the number of average=
s. The
> >  lower limit of the update_interval is 2 ms, the upper limit is 2253 ms.
> > diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/ina3221
> > rename to Documentation/hwmon/ina3221.rst
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.=
rst
> > new file mode 100644
> > index 000000000000..893804414510
> > --- /dev/null
> > +++ b/Documentation/hwmon/index.rst
> > @@ -0,0 +1,179 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +Linux Hardware Monitoring
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> > +   hwmon-kernel-api.rst
> > +   pmbus-core.rst
> > +   submitting-patches.rst
> > +   sysfs-interface.rst
> > +   userspace-tools.rst
> > +
> > +Hardware Monitoring Kernel Drivers
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> > +   ab8500.rst
> > +   abituguru.rst
> > +   abituguru3.rst
> > +   abx500.rst
> > +   acpi_power_meter.rst
> > +   ad7314.rst
> > +   adc128d818.rst
> > +   adm1021.rst
> > +   adm1025.rst
> > +   adm1026.rst
> > +   adm1031.rst
> > +   adm1275.rst
> > +   adm9240.rst
> > +   ads1015.rst
> > +   ads7828.rst
> > +   adt7410.rst
> > +   adt7411.rst
> > +   adt7462.rst
> > +   adt7470.rst
> > +   adt7475.rst
> > +   amc6821.rst
> > +   asb100.rst
> > +   asc7621.rst
> > +   aspeed-pwm-tacho.rst
> > +   coretemp.rst
> > +   da9052.rst
> > +   da9055.rst
> > +   dme1737.rst
> > +   ds1621.rst
> > +   ds620.rst
> > +   emc1403.rst
> > +   emc2103.rst
> > +   emc6w201.rst
> > +   f71805f.rst
> > +   f71882fg.rst
> > +   fam15h_power.rst
> > +   ftsteutates.rst
> > +   g760a.rst
> > +   g762.rst
> > +   gl518sm.rst
> > +   hih6130.rst
> > +   ibmaem.rst
> > +   ibm-cffps.rst
> > +   ibmpowernv.rst
> > +   ina209.rst
> > +   ina2xx.rst
> > +   ina3221.rst
> > +   ir35221.rst
> > +   it87.rst
> > +   jc42.rst
> > +   k10temp.rst
> > +   k8temp.rst
> > +   lineage-pem.rst
> > +   lm25066.rst
> > +   lm63.rst
> > +   lm70.rst
> > +   lm73.rst
> > +   lm75.rst
> > +   lm77.rst
> > +   lm78.rst
> > +   lm80.rst
> > +   lm83.rst
> > +   lm85.rst
> > +   lm87.rst
> > +   lm90.rst
> > +   lm92.rst
> > +   lm93.rst
> > +   lm95234.rst
> > +   lm95245.rst
> > +   ltc2945.rst
> > +   ltc2978.rst
> > +   ltc2990.rst
> > +   ltc3815.rst
> > +   ltc4151.rst
> > +   ltc4215.rst
> > +   ltc4245.rst
> > +   ltc4260.rst
> > +   ltc4261.rst
> > +   max16064.rst
> > +   max16065.rst
> > +   max1619.rst
> > +   max1668.rst
> > +   max197.rst
> > +   max20751.rst
> > +   max31722.rst
> > +   max31785.rst
> > +   max31790.rst
> > +   max34440.rst
> > +   max6639.rst
> > +   max6642.rst
> > +   max6650.rst
> > +   max6697.rst
> > +   max8688.rst
> > +   mc13783-adc.rst
> > +   mcp3021.rst
> > +   menf21bmc.rst
> > +   mlxreg-fan.rst
> > +   nct6683.rst
> > +   nct6775.rst
> > +   nct7802.rst
> > +   nct7904.rst
> > +   npcm750-pwm-fan.rst
> > +   nsa320.rst
> > +   ntc_thermistor.rst
> > +   occ.rst
> > +   pc87360.rst
> > +   pc87427.rst
> > +   pcf8591.rst
> > +   pmbus.rst
> > +   powr1220.rst
> > +   pwm-fan.rst
> > +   raspberrypi-hwmon.rst
> > +   sch5627.rst
> > +   sch5636.rst
> > +   scpi-hwmon.rst
> > +   sht15.rst
> > +   sht21.rst
> > +   sht3x.rst
> > +   shtc1.rst
> > +   sis5595.rst
> > +   smm665.rst
> > +   smsc47b397.rst
> > +   smsc47m192.rst
> > +   smsc47m1.rst
> > +   tc654.rst
> > +   tc74.rst
> > +   thmc50.rst
> > +   tmp102.rst
> > +   tmp103.rst
> > +   tmp108.rst
> > +   tmp401.rst
> > +   tmp421.rst
> > +   tps40422.rst
> > +   twl4030-madc-hwmon.rst
> > +   ucd9000.rst
> > +   ucd9200.rst
> > +   vexpress.rst
> > +   via686a.rst
> > +   vt1211.rst
> > +   w83627ehf.rst
> > +   w83627hf.rst
> > +   w83773g.rst
> > +   w83781d.rst
> > +   w83791d.rst
> > +   w83792d.rst
> > +   w83793.rst
> > +   w83795.rst
> > +   w83l785ts.rst
> > +   w83l786ng.rst
> > +   wm831x.rst
> > +   wm8350.rst
> > +   xgene-hwmon.rst
> > +   zl6100.rst
> > +
> > +.. only::  subproject and html
> > +
> > +   Indices
> > +   =3D=3D=3D=3D=3D=3D=3D
> > +
> > +   * :ref:`genindex`
> > diff --git a/Documentation/hwmon/ir35221 b/Documentation/hwmon/ir35221.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/ir35221
> > rename to Documentation/hwmon/ir35221.rst
> > diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87.rst
> > similarity index 100%
> > rename from Documentation/hwmon/it87
> > rename to Documentation/hwmon/it87.rst
> > diff --git a/Documentation/hwmon/jc42 b/Documentation/hwmon/jc42.rst
> > similarity index 100%
> > rename from Documentation/hwmon/jc42
> > rename to Documentation/hwmon/jc42.rst
> > diff --git a/Documentation/hwmon/k10temp b/Documentation/hwmon/k10temp.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/k10temp
> > rename to Documentation/hwmon/k10temp.rst
> > diff --git a/Documentation/hwmon/k8temp b/Documentation/hwmon/k8temp.rst
> > similarity index 100%
> > rename from Documentation/hwmon/k8temp
> > rename to Documentation/hwmon/k8temp.rst
> > diff --git a/Documentation/hwmon/lineage-pem b/Documentation/hwmon/line=
age-pem.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lineage-pem
> > rename to Documentation/hwmon/lineage-pem.rst
> > diff --git a/Documentation/hwmon/lm25066 b/Documentation/hwmon/lm25066.=
rst
> > similarity index 97%
> > rename from Documentation/hwmon/lm25066
> > rename to Documentation/hwmon/lm25066.rst
> > index 60b7f2722931..da15e3094c8c 100644
> > --- a/Documentation/hwmon/lm25066
> > +++ b/Documentation/hwmon/lm25066.rst
> > @@ -69,7 +69,7 @@ LM25066, LM5064, and LM5066/LM5066I Power Management,=
 Monitoring,
> >  Control, and Protection ICs.
> > =20
> >  The driver is a client driver to the core PMBus driver. Please see
> > -Documentation/hwmon/pmbus for details on PMBus client drivers.
> > +Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> > =20
> > =20
> >  Usage Notes
> > diff --git a/Documentation/hwmon/lm63 b/Documentation/hwmon/lm63.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm63
> > rename to Documentation/hwmon/lm63.rst
> > diff --git a/Documentation/hwmon/lm70 b/Documentation/hwmon/lm70.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm70
> > rename to Documentation/hwmon/lm70.rst
> > diff --git a/Documentation/hwmon/lm73 b/Documentation/hwmon/lm73.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm73
> > rename to Documentation/hwmon/lm73.rst
> > diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm75
> > rename to Documentation/hwmon/lm75.rst
> > diff --git a/Documentation/hwmon/lm77 b/Documentation/hwmon/lm77.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm77
> > rename to Documentation/hwmon/lm77.rst
> > diff --git a/Documentation/hwmon/lm78 b/Documentation/hwmon/lm78.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm78
> > rename to Documentation/hwmon/lm78.rst
> > diff --git a/Documentation/hwmon/lm80 b/Documentation/hwmon/lm80.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm80
> > rename to Documentation/hwmon/lm80.rst
> > diff --git a/Documentation/hwmon/lm83 b/Documentation/hwmon/lm83.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm83
> > rename to Documentation/hwmon/lm83.rst
> > diff --git a/Documentation/hwmon/lm85 b/Documentation/hwmon/lm85.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm85
> > rename to Documentation/hwmon/lm85.rst
> > diff --git a/Documentation/hwmon/lm87 b/Documentation/hwmon/lm87.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm87
> > rename to Documentation/hwmon/lm87.rst
> > diff --git a/Documentation/hwmon/lm90 b/Documentation/hwmon/lm90.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm90
> > rename to Documentation/hwmon/lm90.rst
> > diff --git a/Documentation/hwmon/lm92 b/Documentation/hwmon/lm92.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm92
> > rename to Documentation/hwmon/lm92.rst
> > diff --git a/Documentation/hwmon/lm93 b/Documentation/hwmon/lm93.rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm93
> > rename to Documentation/hwmon/lm93.rst
> > diff --git a/Documentation/hwmon/lm95234 b/Documentation/hwmon/lm95234.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm95234
> > rename to Documentation/hwmon/lm95234.rst
> > diff --git a/Documentation/hwmon/lm95245 b/Documentation/hwmon/lm95245.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/lm95245
> > rename to Documentation/hwmon/lm95245.rst
> > diff --git a/Documentation/hwmon/ltc2945 b/Documentation/hwmon/ltc2945.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/ltc2945
> > rename to Documentation/hwmon/ltc2945.rst
> > diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/ltc2978
> > rename to Documentation/hwmon/ltc2978.rst
> > diff --git a/Documentation/hwmon/ltc2990 b/Documentation/hwmon/ltc2990.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/ltc2990
> > rename to Documentation/hwmon/ltc2990.rst
> > diff --git a/Documentation/hwmon/ltc3815 b/Documentation/hwmon/ltc3815.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/ltc3815
> > rename to Documentation/hwmon/ltc3815.rst
> > diff --git a/Documentation/hwmon/ltc4151 b/Documentation/hwmon/ltc4151.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/ltc4151
> > rename to Documentation/hwmon/ltc4151.rst
> > diff --git a/Documentation/hwmon/ltc4215 b/Documentation/hwmon/ltc4215.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/ltc4215
> > rename to Documentation/hwmon/ltc4215.rst
> > diff --git a/Documentation/hwmon/ltc4245 b/Documentation/hwmon/ltc4245.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/ltc4245
> > rename to Documentation/hwmon/ltc4245.rst
> > diff --git a/Documentation/hwmon/ltc4260 b/Documentation/hwmon/ltc4260.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/ltc4260
> > rename to Documentation/hwmon/ltc4260.rst
> > diff --git a/Documentation/hwmon/ltc4261 b/Documentation/hwmon/ltc4261.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/ltc4261
> > rename to Documentation/hwmon/ltc4261.rst
> > diff --git a/Documentation/hwmon/max16064 b/Documentation/hwmon/max1606=
4.rst
> > similarity index 96%
> > rename from Documentation/hwmon/max16064
> > rename to Documentation/hwmon/max16064.rst
> > index 61ec679dc477..6d5e9538991f 100644
> > --- a/Documentation/hwmon/max16064
> > +++ b/Documentation/hwmon/max16064.rst
> > @@ -21,7 +21,7 @@ This driver supports hardware monitoring for Maxim MA=
X16064 Quad Power-Supply
> >  Controller with Active-Voltage Output Control and PMBus Interface.
> > =20
> >  The driver is a client driver to the core PMBus driver.
> > -Please see Documentation/hwmon/pmbus for details on PMBus client drive=
rs.
> > +Please see Documentation/hwmon/pmbus.rst for details on PMBus client d=
rivers.
> > =20
> > =20
> >  Usage Notes
> > diff --git a/Documentation/hwmon/max16065 b/Documentation/hwmon/max1606=
5.rst
> > similarity index 100%
> > rename from Documentation/hwmon/max16065
> > rename to Documentation/hwmon/max16065.rst
> > diff --git a/Documentation/hwmon/max1619 b/Documentation/hwmon/max1619.=
rst
> > similarity index 99%
> > rename from Documentation/hwmon/max1619
> > rename to Documentation/hwmon/max1619.rst
> > index 4b3762c4eceb..e25956e70f73 100644
> > --- a/Documentation/hwmon/max1619
> > +++ b/Documentation/hwmon/max1619.rst
> > @@ -31,4 +31,3 @@ Only the external sensor has high and low limits.
> >  The max1619 driver will not update its values more frequently than eve=
ry
> >  other second; reading them more often will do no harm, but will return
> >  'old' values.
> > -
> > diff --git a/Documentation/hwmon/max1668 b/Documentation/hwmon/max1668.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/max1668
> > rename to Documentation/hwmon/max1668.rst
> > diff --git a/Documentation/hwmon/max197 b/Documentation/hwmon/max197.rst
> > similarity index 100%
> > rename from Documentation/hwmon/max197
> > rename to Documentation/hwmon/max197.rst
> > diff --git a/Documentation/hwmon/max20751 b/Documentation/hwmon/max2075=
1.rst
> > similarity index 96%
> > rename from Documentation/hwmon/max20751
> > rename to Documentation/hwmon/max20751.rst
> > index d546695900ef..aa4469be6674 100644
> > --- a/Documentation/hwmon/max20751
> > +++ b/Documentation/hwmon/max20751.rst
> > @@ -23,7 +23,7 @@ This driver supports MAX20751 Multiphase Master with =
PMBus Interface
> >  and Internal Buck Converter.
> > =20
> >  The driver is a client driver to the core PMBus driver.
> > -Please see Documentation/hwmon/pmbus for details on PMBus client drive=
rs.
> > +Please see Documentation/hwmon/pmbus.rst for details on PMBus client d=
rivers.
> > =20
> > =20
> >  Usage Notes
> > diff --git a/Documentation/hwmon/max31722 b/Documentation/hwmon/max3172=
2.rst
> > similarity index 100%
> > rename from Documentation/hwmon/max31722
> > rename to Documentation/hwmon/max31722.rst
> > diff --git a/Documentation/hwmon/max31785 b/Documentation/hwmon/max3178=
5.rst
> > similarity index 100%
> > rename from Documentation/hwmon/max31785
> > rename to Documentation/hwmon/max31785.rst
> > diff --git a/Documentation/hwmon/max31790 b/Documentation/hwmon/max3179=
0.rst
> > similarity index 100%
> > rename from Documentation/hwmon/max31790
> > rename to Documentation/hwmon/max31790.rst
> > diff --git a/Documentation/hwmon/max34440 b/Documentation/hwmon/max3444=
0.rst
> > similarity index 98%
> > rename from Documentation/hwmon/max34440
> > rename to Documentation/hwmon/max34440.rst
> > index 639838ef29fd..939138e12b02 100644
> > --- a/Documentation/hwmon/max34440
> > +++ b/Documentation/hwmon/max34440.rst
> > @@ -76,7 +76,7 @@ based on GIN pins. The MAX34460 supports 12 voltage c=
hannels, and the MAX34461
> >  supports 16 voltage channels.
> > =20
> >  The driver is a client driver to the core PMBus driver. Please see
> > -Documentation/hwmon/pmbus for details on PMBus client drivers.
> > +Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> > =20
> > =20
> >  Usage Notes
> > diff --git a/Documentation/hwmon/max6639 b/Documentation/hwmon/max6639.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/max6639
> > rename to Documentation/hwmon/max6639.rst
> > diff --git a/Documentation/hwmon/max6642 b/Documentation/hwmon/max6642.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/max6642
> > rename to Documentation/hwmon/max6642.rst
> > diff --git a/Documentation/hwmon/max6650 b/Documentation/hwmon/max6650.=
rst
> > similarity index 99%
> > rename from Documentation/hwmon/max6650
> > rename to Documentation/hwmon/max6650.rst
> > index 74dc3f0caaa2..253482add082 100644
> > --- a/Documentation/hwmon/max6650
> > +++ b/Documentation/hwmon/max6650.rst
> > @@ -72,4 +72,3 @@ clock: The clock frequency in Hz of the chip the driv=
er should assume [254000]
> > =20
> >  Please have a look at the MAX6650/6651 data sheet and make sure that y=
ou fully
> >  understand the meaning of these parameters before you attempt to chang=
e them.
> > -
> > diff --git a/Documentation/hwmon/max6697 b/Documentation/hwmon/max6697.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/max6697
> > rename to Documentation/hwmon/max6697.rst
> > diff --git a/Documentation/hwmon/max8688 b/Documentation/hwmon/max8688.=
rst
> > similarity index 97%
> > rename from Documentation/hwmon/max8688
> > rename to Documentation/hwmon/max8688.rst
> > index 43da139234c1..009487759c61 100644
> > --- a/Documentation/hwmon/max8688
> > +++ b/Documentation/hwmon/max8688.rst
> > @@ -21,7 +21,7 @@ This driver supports hardware monitoring for Maxim MA=
X8688 Digital Power-Supply
> >  Controller/Monitor with PMBus Interface.
> > =20
> >  The driver is a client driver to the core PMBus driver. Please see
> > -Documentation/hwmon/pmbus for details on PMBus client drivers.
> > +Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> > =20
> > =20
> >  Usage Notes
> > diff --git a/Documentation/hwmon/mc13783-adc b/Documentation/hwmon/mc13=
783-adc.rst
> > similarity index 100%
> > rename from Documentation/hwmon/mc13783-adc
> > rename to Documentation/hwmon/mc13783-adc.rst
> > diff --git a/Documentation/hwmon/mcp3021 b/Documentation/hwmon/mcp3021.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/mcp3021
> > rename to Documentation/hwmon/mcp3021.rst
> > diff --git a/Documentation/hwmon/menf21bmc b/Documentation/hwmon/menf21=
bmc.rst
> > similarity index 100%
> > rename from Documentation/hwmon/menf21bmc
> > rename to Documentation/hwmon/menf21bmc.rst
> > diff --git a/Documentation/hwmon/mlxreg-fan b/Documentation/hwmon/mlxre=
g-fan.rst
> > similarity index 100%
> > rename from Documentation/hwmon/mlxreg-fan
> > rename to Documentation/hwmon/mlxreg-fan.rst
> > diff --git a/Documentation/hwmon/nct6683 b/Documentation/hwmon/nct6683.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/nct6683
> > rename to Documentation/hwmon/nct6683.rst
> > diff --git a/Documentation/hwmon/nct6775 b/Documentation/hwmon/nct6775.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/nct6775
> > rename to Documentation/hwmon/nct6775.rst
> > diff --git a/Documentation/hwmon/nct7802 b/Documentation/hwmon/nct7802.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/nct7802
> > rename to Documentation/hwmon/nct7802.rst
> > diff --git a/Documentation/hwmon/nct7904 b/Documentation/hwmon/nct7904.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/nct7904
> > rename to Documentation/hwmon/nct7904.rst
> > diff --git a/Documentation/hwmon/npcm750-pwm-fan b/Documentation/hwmon/=
npcm750-pwm-fan.rst
> > similarity index 100%
> > rename from Documentation/hwmon/npcm750-pwm-fan
> > rename to Documentation/hwmon/npcm750-pwm-fan.rst
> > diff --git a/Documentation/hwmon/nsa320 b/Documentation/hwmon/nsa320.rst
> > similarity index 100%
> > rename from Documentation/hwmon/nsa320
> > rename to Documentation/hwmon/nsa320.rst
> > diff --git a/Documentation/hwmon/ntc_thermistor b/Documentation/hwmon/n=
tc_thermistor.rst
> > similarity index 100%
> > rename from Documentation/hwmon/ntc_thermistor
> > rename to Documentation/hwmon/ntc_thermistor.rst
> > diff --git a/Documentation/hwmon/occ b/Documentation/hwmon/occ.rst
> > similarity index 100%
> > rename from Documentation/hwmon/occ
> > rename to Documentation/hwmon/occ.rst
> > diff --git a/Documentation/hwmon/pc87360 b/Documentation/hwmon/pc87360.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/pc87360
> > rename to Documentation/hwmon/pc87360.rst
> > diff --git a/Documentation/hwmon/pc87427 b/Documentation/hwmon/pc87427.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/pc87427
> > rename to Documentation/hwmon/pc87427.rst
> > diff --git a/Documentation/hwmon/pcf8591 b/Documentation/hwmon/pcf8591.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/pcf8591
> > rename to Documentation/hwmon/pcf8591.rst
> > diff --git a/Documentation/hwmon/pmbus-core b/Documentation/hwmon/pmbus=
-core.rst
> > similarity index 100%
> > rename from Documentation/hwmon/pmbus-core
> > rename to Documentation/hwmon/pmbus-core.rst
> > diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus.rst
> > similarity index 100%
> > rename from Documentation/hwmon/pmbus
> > rename to Documentation/hwmon/pmbus.rst
> > diff --git a/Documentation/hwmon/powr1220 b/Documentation/hwmon/powr122=
0.rst
> > similarity index 100%
> > rename from Documentation/hwmon/powr1220
> > rename to Documentation/hwmon/powr1220.rst
> > diff --git a/Documentation/hwmon/pwm-fan b/Documentation/hwmon/pwm-fan.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/pwm-fan
> > rename to Documentation/hwmon/pwm-fan.rst
> > diff --git a/Documentation/hwmon/raspberrypi-hwmon b/Documentation/hwmo=
n/raspberrypi-hwmon.rst
> > similarity index 100%
> > rename from Documentation/hwmon/raspberrypi-hwmon
> > rename to Documentation/hwmon/raspberrypi-hwmon.rst
> > diff --git a/Documentation/hwmon/sch5627 b/Documentation/hwmon/sch5627.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/sch5627
> > rename to Documentation/hwmon/sch5627.rst
> > diff --git a/Documentation/hwmon/sch5636 b/Documentation/hwmon/sch5636.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/sch5636
> > rename to Documentation/hwmon/sch5636.rst
> > diff --git a/Documentation/hwmon/scpi-hwmon b/Documentation/hwmon/scpi-=
hwmon.rst
> > similarity index 100%
> > rename from Documentation/hwmon/scpi-hwmon
> > rename to Documentation/hwmon/scpi-hwmon.rst
> > diff --git a/Documentation/hwmon/sht15 b/Documentation/hwmon/sht15.rst
> > similarity index 100%
> > rename from Documentation/hwmon/sht15
> > rename to Documentation/hwmon/sht15.rst
> > diff --git a/Documentation/hwmon/sht21 b/Documentation/hwmon/sht21.rst
> > similarity index 100%
> > rename from Documentation/hwmon/sht21
> > rename to Documentation/hwmon/sht21.rst
> > diff --git a/Documentation/hwmon/sht3x b/Documentation/hwmon/sht3x.rst
> > similarity index 100%
> > rename from Documentation/hwmon/sht3x
> > rename to Documentation/hwmon/sht3x.rst
> > diff --git a/Documentation/hwmon/shtc1 b/Documentation/hwmon/shtc1.rst
> > similarity index 100%
> > rename from Documentation/hwmon/shtc1
> > rename to Documentation/hwmon/shtc1.rst
> > diff --git a/Documentation/hwmon/sis5595 b/Documentation/hwmon/sis5595.=
rst
> > similarity index 99%
> > rename from Documentation/hwmon/sis5595
> > rename to Documentation/hwmon/sis5595.rst
> > index 5acba6b0c0db..16123b3bfff9 100644
> > --- a/Documentation/hwmon/sis5595
> > +++ b/Documentation/hwmon/sis5595.rst
> > @@ -121,4 +121,3 @@ Problems
> >  --------
> >  Some chips refuse to be enabled. We don't know why.
> >  The driver will recognize this and print a message in dmesg.
> > -
> > diff --git a/Documentation/hwmon/smm665 b/Documentation/hwmon/smm665.rst
> > similarity index 100%
> > rename from Documentation/hwmon/smm665
> > rename to Documentation/hwmon/smm665.rst
> > diff --git a/Documentation/hwmon/smsc47b397 b/Documentation/hwmon/smsc4=
7b397.rst
> > similarity index 100%
> > rename from Documentation/hwmon/smsc47b397
> > rename to Documentation/hwmon/smsc47b397.rst
> > diff --git a/Documentation/hwmon/smsc47m1 b/Documentation/hwmon/smsc47m=
1.rst
> > similarity index 100%
> > rename from Documentation/hwmon/smsc47m1
> > rename to Documentation/hwmon/smsc47m1.rst
> > diff --git a/Documentation/hwmon/smsc47m192 b/Documentation/hwmon/smsc4=
7m192.rst
> > similarity index 100%
> > rename from Documentation/hwmon/smsc47m192
> > rename to Documentation/hwmon/smsc47m192.rst
> > diff --git a/Documentation/hwmon/submitting-patches b/Documentation/hwm=
on/submitting-patches.rst
> > similarity index 98%
> > rename from Documentation/hwmon/submitting-patches
> > rename to Documentation/hwmon/submitting-patches.rst
> > index 12540b7d9b50..f9796b9d9db6 100644
> > --- a/Documentation/hwmon/submitting-patches
> > +++ b/Documentation/hwmon/submitting-patches.rst
> > @@ -39,7 +39,7 @@ increase the chances of your change being accepted.
> >  2. Adding functionality to existing drivers
> >  -------------------------------------------
> > =20
> > -* Make sure the documentation in Documentation/hwmon/<driver_name> is =
up to
> > +* Make sure the documentation in Documentation/hwmon/<driver_name>.rst=
 is up to
> >    date.
> > =20
> >  * Make sure the information in Kconfig is up to date.
> > @@ -61,7 +61,7 @@ increase the chances of your change being accepted.
> > =20
> >  * Consider adding yourself to MAINTAINERS.
> > =20
> > -* Document the driver in Documentation/hwmon/<driver_name>.
> > +* Document the driver in Documentation/hwmon/<driver_name>.rst.
> > =20
> >  * Add the driver to Kconfig and Makefile in alphabetical order.
> > =20
> > @@ -134,7 +134,7 @@ increase the chances of your change being accepted.
> >    non-standard attributes, or you believe you do, discuss it on the ma=
iling list
> >    first. Either case, provide a detailed explanation why you need the
> >    non-standard attribute(s).
> > -  Standard attributes are specified in Documentation/hwmon/sysfs-inter=
face.
> > +  Standard attributes are specified in Documentation/hwmon/sysfs-inter=
face.rst.
> > =20
> >  * When deciding which sysfs attributes to support, look at the chip's
> >    capabilities. While we do not expect your driver to support everythi=
ng the
> > diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/=
sysfs-interface.rst
> > similarity index 100%
> > rename from Documentation/hwmon/sysfs-interface
> > rename to Documentation/hwmon/sysfs-interface.rst
> > diff --git a/Documentation/hwmon/tc654 b/Documentation/hwmon/tc654.rst
> > similarity index 100%
> > rename from Documentation/hwmon/tc654
> > rename to Documentation/hwmon/tc654.rst
> > diff --git a/Documentation/hwmon/tc74 b/Documentation/hwmon/tc74.rst
> > similarity index 100%
> > rename from Documentation/hwmon/tc74
> > rename to Documentation/hwmon/tc74.rst
> > diff --git a/Documentation/hwmon/thmc50 b/Documentation/hwmon/thmc50.rst
> > similarity index 99%
> > rename from Documentation/hwmon/thmc50
> > rename to Documentation/hwmon/thmc50.rst
> > index 6dba1b59b20c..cfff3885287d 100644
> > --- a/Documentation/hwmon/thmc50
> > +++ b/Documentation/hwmon/thmc50.rst
> > @@ -87,4 +87,3 @@ so it stops fans even if the value 0 into the ANALOG_=
OUT register does not.
> > =20
> >  The driver was tested on Compaq AP550 with two ADM1022 chips (one works
> >  in the temp3 mode), five temperature readings and two fans.
> > -
> > diff --git a/Documentation/hwmon/tmp102 b/Documentation/hwmon/tmp102.rst
> > similarity index 93%
> > rename from Documentation/hwmon/tmp102
> > rename to Documentation/hwmon/tmp102.rst
> > index 5e34821df4ab..b1f585531a88 100644
> > --- a/Documentation/hwmon/tmp102
> > +++ b/Documentation/hwmon/tmp102.rst
> > @@ -28,4 +28,4 @@ The TMP102 has a programmable update rate that can se=
lect between 8, 4, 1, and
> >  0.5 Hz. (Currently the driver only supports the default of 4 Hz).
> > =20
> >  The driver provides the common sysfs-interface for temperatures (see
> > -Documentation/hwmon/sysfs-interface under Temperatures).
> > +Documentation/hwmon/sysfs-interface.rst under Temperatures).
> > diff --git a/Documentation/hwmon/tmp103 b/Documentation/hwmon/tmp103.rst
> > similarity index 92%
> > rename from Documentation/hwmon/tmp103
> > rename to Documentation/hwmon/tmp103.rst
> > index 7682a795e38c..15d25806d585 100644
> > --- a/Documentation/hwmon/tmp103
> > +++ b/Documentation/hwmon/tmp103.rst
> > @@ -27,7 +27,7 @@ Resolution: 8 Bits
> >  Accuracy: =C2=B11=C2=B0C Typ (=E2=80=9310=C2=B0C to +100=C2=B0C)
> > =20
> >  The driver provides the common sysfs-interface for temperatures (see
> > -Documentation/hwmon/sysfs-interface under Temperatures).
> > +Documentation/hwmon/sysfs-interface.rst under Temperatures).
> > =20
> >  Please refer how to instantiate this driver:
> >  Documentation/i2c/instantiating-devices
> > diff --git a/Documentation/hwmon/tmp108 b/Documentation/hwmon/tmp108.rst
> > similarity index 95%
> > rename from Documentation/hwmon/tmp108
> > rename to Documentation/hwmon/tmp108.rst
> > index 7e08b7ef1e2f..5f4266a16cb2 100644
> > --- a/Documentation/hwmon/tmp108
> > +++ b/Documentation/hwmon/tmp108.rst
> > @@ -38,4 +38,4 @@ and then the device is shut down automatically. (This=
 driver only supports
> >  continuous mode.)
> > =20
> >  The driver provides the common sysfs-interface for temperatures (see
> > -Documentation/hwmon/sysfs-interface under Temperatures).
> > +Documentation/hwmon/sysfs-interface.rst under Temperatures).
> > diff --git a/Documentation/hwmon/tmp401 b/Documentation/hwmon/tmp401.rst
> > similarity index 97%
> > rename from Documentation/hwmon/tmp401
> > rename to Documentation/hwmon/tmp401.rst
> > index bd865bbdb38d..6a05a0719bc7 100644
> > --- a/Documentation/hwmon/tmp401
> > +++ b/Documentation/hwmon/tmp401.rst
> > @@ -68,7 +68,7 @@ supported by the driver so far, so using the default =
resolution of 0.5
> >  degree).
> > =20
> >  The driver provides the common sysfs-interface for temperatures (see
> > -Documentation/hwmon/sysfs-interface under Temperatures).
> > +Documentation/hwmon/sysfs-interface.rst under Temperatures).
> > =20
> >  The TMP411 and TMP431 chips are compatible with TMP401. TMP411 provides
> >  some additional features.
> > diff --git a/Documentation/hwmon/tmp421 b/Documentation/hwmon/tmp421.rst
> > similarity index 100%
> > rename from Documentation/hwmon/tmp421
> > rename to Documentation/hwmon/tmp421.rst
> > diff --git a/Documentation/hwmon/tps40422 b/Documentation/hwmon/tps4042=
2.rst
> > similarity index 96%
> > rename from Documentation/hwmon/tps40422
> > rename to Documentation/hwmon/tps40422.rst
> > index 359751eb5ed4..b691e30479dd 100644
> > --- a/Documentation/hwmon/tps40422
> > +++ b/Documentation/hwmon/tps40422.rst
> > @@ -21,7 +21,7 @@ This driver supports TI TPS40422 Dual-Output or Two-P=
hase Synchronous Buck
> >  Controller with PMBus
> > =20
> >  The driver is a client driver to the core PMBus driver.
> > -Please see Documentation/hwmon/pmbus for details on PMBus client drive=
rs.
> > +Please see Documentation/hwmon/pmbus.rst for details on PMBus client d=
rivers.
> > =20
> > =20
> >  Usage Notes
> > diff --git a/Documentation/hwmon/twl4030-madc-hwmon b/Documentation/hwm=
on/twl4030-madc-hwmon.rst
> > similarity index 100%
> > rename from Documentation/hwmon/twl4030-madc-hwmon
> > rename to Documentation/hwmon/twl4030-madc-hwmon.rst
> > diff --git a/Documentation/hwmon/ucd9000 b/Documentation/hwmon/ucd9000.=
rst
> > similarity index 97%
> > rename from Documentation/hwmon/ucd9000
> > rename to Documentation/hwmon/ucd9000.rst
> > index d69061b7312c..ebc4f2b3bfea 100644
> > --- a/Documentation/hwmon/ucd9000
> > +++ b/Documentation/hwmon/ucd9000.rst
> > @@ -57,7 +57,7 @@ system-health monitor. The device integrates a 12-bit=
 ADC for monitoring up to
> >  13 power-supply voltage, current, or temperature inputs.
> > =20
> >  This driver is a client driver to the core PMBus driver. Please see
> > -Documentation/hwmon/pmbus for details on PMBus client drivers.
> > +Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> > =20
> > =20
> >  Usage Notes
> > @@ -72,7 +72,7 @@ Platform data support
> >  ---------------------
> > =20
> >  The driver supports standard PMBus driver platform data. Please see
> > -Documentation/hwmon/pmbus for details.
> > +Documentation/hwmon/pmbus.rst for details.
> > =20
> > =20
> >  Sysfs entries
> > diff --git a/Documentation/hwmon/ucd9200 b/Documentation/hwmon/ucd9200.=
rst
> > similarity index 97%
> > rename from Documentation/hwmon/ucd9200
> > rename to Documentation/hwmon/ucd9200.rst
> > index 44eda4a579b6..b819dfd75f71 100644
> > --- a/Documentation/hwmon/ucd9200
> > +++ b/Documentation/hwmon/ucd9200.rst
> > @@ -33,7 +33,7 @@ dedicated circuitry for DC/DC loop management with fl=
ash memory and a serial
> >  interface to support configuration, monitoring and management.
> > =20
> >  This driver is a client driver to the core PMBus driver. Please see
> > -Documentation/hwmon/pmbus for details on PMBus client drivers.
> > +Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
> > =20
> > =20
> >  Usage Notes
> > @@ -48,7 +48,7 @@ Platform data support
> >  ---------------------
> > =20
> >  The driver supports standard PMBus driver platform data. Please see
> > -Documentation/hwmon/pmbus for details.
> > +Documentation/hwmon/pmbus.rst for details.
> > =20
> > =20
> >  Sysfs entries
> > diff --git a/Documentation/hwmon/userspace-tools b/Documentation/hwmon/=
userspace-tools.rst
> > similarity index 100%
> > rename from Documentation/hwmon/userspace-tools
> > rename to Documentation/hwmon/userspace-tools.rst
> > diff --git a/Documentation/hwmon/vexpress b/Documentation/hwmon/vexpres=
s.rst
> > similarity index 100%
> > rename from Documentation/hwmon/vexpress
> > rename to Documentation/hwmon/vexpress.rst
> > diff --git a/Documentation/hwmon/via686a b/Documentation/hwmon/via686a.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/via686a
> > rename to Documentation/hwmon/via686a.rst
> > diff --git a/Documentation/hwmon/vt1211 b/Documentation/hwmon/vt1211.rst
> > similarity index 100%
> > rename from Documentation/hwmon/vt1211
> > rename to Documentation/hwmon/vt1211.rst
> > diff --git a/Documentation/hwmon/w83627ehf b/Documentation/hwmon/w83627=
ehf.rst
> > similarity index 100%
> > rename from Documentation/hwmon/w83627ehf
> > rename to Documentation/hwmon/w83627ehf.rst
> > diff --git a/Documentation/hwmon/w83627hf b/Documentation/hwmon/w83627h=
f.rst
> > similarity index 100%
> > rename from Documentation/hwmon/w83627hf
> > rename to Documentation/hwmon/w83627hf.rst
> > diff --git a/Documentation/hwmon/w83773g b/Documentation/hwmon/w83773g.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/w83773g
> > rename to Documentation/hwmon/w83773g.rst
> > diff --git a/Documentation/hwmon/w83781d b/Documentation/hwmon/w83781d.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/w83781d
> > rename to Documentation/hwmon/w83781d.rst
> > diff --git a/Documentation/hwmon/w83791d b/Documentation/hwmon/w83791d.=
rst
> > similarity index 99%
> > rename from Documentation/hwmon/w83791d
> > rename to Documentation/hwmon/w83791d.rst
> > index a91f9e5fb0c6..3adaed39b157 100644
> > --- a/Documentation/hwmon/w83791d
> > +++ b/Documentation/hwmon/w83791d.rst
> > @@ -102,7 +102,7 @@ This file is used for both legacy and new code.
> > =20
> >  The sysfs interface to the beep bitmask has migrated from the original=
 legacy
> >  method of a single sysfs beep_mask file to a newer method using multip=
le
> > -`*_beep` files as described in `Documentation/hwmon/sysfs-interface`.
> > +`*_beep` files as described in `Documentation/hwmon/sysfs-interface.rs=
t`.
> > =20
> >  A similar change has occurred for the bitmap corresponding to the alar=
ms. The
> >  original legacy method used a single sysfs alarms file containing a bi=
tmap
> > diff --git a/Documentation/hwmon/w83792d b/Documentation/hwmon/w83792d.=
rst
> > similarity index 100%
> > rename from Documentation/hwmon/w83792d
> > rename to Documentation/hwmon/w83792d.rst
> > diff --git a/Documentation/hwmon/w83793 b/Documentation/hwmon/w83793.rst
> > similarity index 100%
> > rename from Documentation/hwmon/w83793
> > rename to Documentation/hwmon/w83793.rst
> > diff --git a/Documentation/hwmon/w83795 b/Documentation/hwmon/w83795.rst
> > similarity index 100%
> > rename from Documentation/hwmon/w83795
> > rename to Documentation/hwmon/w83795.rst
> > diff --git a/Documentation/hwmon/w83l785ts b/Documentation/hwmon/w83l78=
5ts.rst
> > similarity index 100%
> > rename from Documentation/hwmon/w83l785ts
> > rename to Documentation/hwmon/w83l785ts.rst
> > diff --git a/Documentation/hwmon/w83l786ng b/Documentation/hwmon/w83l78=
6ng.rst
> > similarity index 100%
> > rename from Documentation/hwmon/w83l786ng
> > rename to Documentation/hwmon/w83l786ng.rst
> > diff --git a/Documentation/hwmon/wm831x b/Documentation/hwmon/wm831x.rst
> > similarity index 100%
> > rename from Documentation/hwmon/wm831x
> > rename to Documentation/hwmon/wm831x.rst
> > diff --git a/Documentation/hwmon/wm8350 b/Documentation/hwmon/wm8350.rst
> > similarity index 100%
> > rename from Documentation/hwmon/wm8350
> > rename to Documentation/hwmon/wm8350.rst
> > diff --git a/Documentation/hwmon/xgene-hwmon b/Documentation/hwmon/xgen=
e-hwmon.rst
> > similarity index 100%
> > rename from Documentation/hwmon/xgene-hwmon
> > rename to Documentation/hwmon/xgene-hwmon.rst
> > diff --git a/Documentation/hwmon/zl6100 b/Documentation/hwmon/zl6100.rst
> > similarity index 98%
> > rename from Documentation/hwmon/zl6100
> > rename to Documentation/hwmon/zl6100.rst
> > index 4029970bace4..41513bb7fe51 100644
> > --- a/Documentation/hwmon/zl6100
> > +++ b/Documentation/hwmon/zl6100.rst
> > @@ -113,7 +113,7 @@ This driver supports hardware monitoring for Inters=
il / Zilker Labs ZL6100 and
> >  compatible digital DC-DC controllers.
> > =20
> >  The driver is a client driver to the core PMBus driver. Please see
> > -Documentation/hwmon/pmbus and Documentation.hwmon/pmbus-core for detai=
ls
> > +Documentation/hwmon/pmbus.rst and Documentation.hwmon/pmbus-core for d=
etails
> >  on PMBus client drivers.
> > =20
> > =20
> > diff --git a/Documentation/index.rst b/Documentation/index.rst
> > index 80a421cb935e..3a710dc24fc8 100644
> > --- a/Documentation/index.rst
> > +++ b/Documentation/index.rst
> > @@ -83,6 +83,7 @@ needed).
> >     media/index
> >     networking/index
> >     input/index
> > +   hwmon/index
> >     gpu/index
> >     security/index
> >     sound/index
> > diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/therma=
l/sysfs-api.txt
> > index 911399730c1c..c3fa500df92c 100644
> > --- a/Documentation/thermal/sysfs-api.txt
> > +++ b/Documentation/thermal/sysfs-api.txt
> > @@ -316,7 +316,7 @@ ACPI thermal zones.
> >      |---temp[1-*]_input:	The current temperature of thermal zone [1-*]
> >      |---temp[1-*]_critical:	The critical trip point of thermal zone [1=
-*]
> > =20
> > -Please read Documentation/hwmon/sysfs-interface for additional informa=
tion.
> > +Please read Documentation/hwmon/sysfs-interface.rst for additional inf=
ormation.
> > =20
> >  ***************************
> >  * Thermal zone attributes *
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 349e5d8c3f58..6269c9d671ca 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -468,7 +468,7 @@ ADM1025 HARDWARE MONITOR DRIVER
> >  M:	Jean Delvare <jdelvare@suse.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/adm1025
> > +F:	Documentation/hwmon/adm1025.rst
> >  F:	drivers/hwmon/adm1025.c
> > =20
> >  ADM1029 HARDWARE MONITOR DRIVER
> > @@ -520,7 +520,7 @@ ADS1015 HARDWARE MONITOR DRIVER
> >  M:	Dirk Eibach <eibach@gdsys.de>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/ads1015
> > +F:	Documentation/hwmon/ads1015.rst
> >  F:	drivers/hwmon/ads1015.c
> >  F:	include/linux/platform_data/ads1015.h
> > =20
> > @@ -533,7 +533,7 @@ ADT7475 HARDWARE MONITOR DRIVER
> >  M:	Jean Delvare <jdelvare@suse.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/adt7475
> > +F:	Documentation/hwmon/adt7475.rst
> >  F:	drivers/hwmon/adt7475.c
> > =20
> >  ADVANSYS SCSI DRIVER
> > @@ -764,7 +764,7 @@ AMD FAM15H PROCESSOR POWER MONITORING DRIVER
> >  M:	Huang Rui <ray.huang@amd.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Supported
> > -F:	Documentation/hwmon/fam15h_power
> > +F:	Documentation/hwmon/fam15h_power.rst
> >  F:	drivers/hwmon/fam15h_power.c
> > =20
> >  AMD FCH GPIO DRIVER
> > @@ -2531,7 +2531,7 @@ ASC7621 HARDWARE MONITOR DRIVER
> >  M:	George Joseph <george.joseph@fairview5.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/asc7621
> > +F:	Documentation/hwmon/asc7621.rst
> >  F:	drivers/hwmon/asc7621.c
> > =20
> >  ASPEED VIDEO ENGINE DRIVER
> > @@ -4071,7 +4071,7 @@ CORETEMP HARDWARE MONITORING DRIVER
> >  M:	Fenghua Yu <fenghua.yu@intel.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/coretemp
> > +F:	Documentation/hwmon/coretemp.rst
> >  F:	drivers/hwmon/coretemp.c
> > =20
> >  COSA/SRP SYNC SERIAL DRIVER
> > @@ -4627,7 +4627,7 @@ DIALOG SEMICONDUCTOR DRIVERS
> >  M:	Support Opensource <support.opensource@diasemi.com>
> >  W:	http://www.dialog-semiconductor.com/products
> >  S:	Supported
> > -F:	Documentation/hwmon/da90??
> > +F:	Documentation/hwmon/da90??.rst
> >  F:	Documentation/devicetree/bindings/mfd/da90*.txt
> >  F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
> >  F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
> > @@ -4778,7 +4778,7 @@ DME1737 HARDWARE MONITOR DRIVER
> >  M:	Juerg Haefliger <juergh@gmail.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/dme1737
> > +F:	Documentation/hwmon/dme1737.rst
> >  F:	drivers/hwmon/dme1737.c
> > =20
> >  DMI/SMBIOS SUPPORT
> > @@ -6006,7 +6006,7 @@ F71805F HARDWARE MONITORING DRIVER
> >  M:	Jean Delvare <jdelvare@suse.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/f71805f
> > +F:	Documentation/hwmon/f71805f.rst
> >  F:	drivers/hwmon/f71805f.c
> > =20
> >  FADDR2LINE
> > @@ -7687,7 +7687,7 @@ INA209 HARDWARE MONITOR DRIVER
> >  M:	Guenter Roeck <linux@roeck-us.net>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/ina209
> > +F:	Documentation/hwmon/ina209.rst
> >  F:	Documentation/devicetree/bindings/hwmon/ina2xx.txt
> >  F:	drivers/hwmon/ina209.c
> > =20
> > @@ -7695,7 +7695,7 @@ INA2XX HARDWARE MONITOR DRIVER
> >  M:	Guenter Roeck <linux@roeck-us.net>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/ina2xx
> > +F:	Documentation/hwmon/ina2xx.rst
> >  F:	drivers/hwmon/ina2xx.c
> >  F:	include/linux/platform_data/ina2xx.h
> > =20
> > @@ -8328,7 +8328,7 @@ IT87 HARDWARE MONITORING DRIVER
> >  M:	Jean Delvare <jdelvare@suse.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/it87
> > +F:	Documentation/hwmon/it87.rst
> >  F:	drivers/hwmon/it87.c
> > =20
> >  IT913X MEDIA DRIVER
> > @@ -8372,7 +8372,7 @@ M:	Guenter Roeck <linux@roeck-us.net>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/hwmon/jc42.c
> > -F:	Documentation/hwmon/jc42
> > +F:	Documentation/hwmon/jc42.rst
> > =20
> >  JFS FILESYSTEM
> >  M:	Dave Kleikamp <shaggy@kernel.org>
> > @@ -8420,14 +8420,14 @@ K10TEMP HARDWARE MONITORING DRIVER
> >  M:	Clemens Ladisch <clemens@ladisch.de>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/k10temp
> > +F:	Documentation/hwmon/k10temp.rst
> >  F:	drivers/hwmon/k10temp.c
> > =20
> >  K8TEMP HARDWARE MONITORING DRIVER
> >  M:	Rudolf Marek <r.marek@assembler.cz>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/k8temp
> > +F:	Documentation/hwmon/k8temp.rst
> >  F:	drivers/hwmon/k8temp.c
> > =20
> >  KASAN
> > @@ -9118,21 +9118,21 @@ LM78 HARDWARE MONITOR DRIVER
> >  M:	Jean Delvare <jdelvare@suse.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/lm78
> > +F:	Documentation/hwmon/lm78.rst
> >  F:	drivers/hwmon/lm78.c
> > =20
> >  LM83 HARDWARE MONITOR DRIVER
> >  M:	Jean Delvare <jdelvare@suse.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/lm83
> > +F:	Documentation/hwmon/lm83.rst
> >  F:	drivers/hwmon/lm83.c
> > =20
> >  LM90 HARDWARE MONITOR DRIVER
> >  M:	Jean Delvare <jdelvare@suse.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/lm90
> > +F:	Documentation/hwmon/lm90.rst
> >  F:	Documentation/devicetree/bindings/hwmon/lm90.txt
> >  F:	drivers/hwmon/lm90.c
> >  F:	include/dt-bindings/thermal/lm90.h
> > @@ -9141,7 +9141,7 @@ LM95234 HARDWARE MONITOR DRIVER
> >  M:	Guenter Roeck <linux@roeck-us.net>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/lm95234
> > +F:	Documentation/hwmon/lm95234.rst
> >  F:	drivers/hwmon/lm95234.c
> > =20
> >  LME2510 MEDIA DRIVER
> > @@ -9214,7 +9214,7 @@ LTC4261 HARDWARE MONITOR DRIVER
> >  M:	Guenter Roeck <linux@roeck-us.net>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/ltc4261
> > +F:	Documentation/hwmon/ltc4261.rst
> >  F:	drivers/hwmon/ltc4261.c
> > =20
> >  LTC4306 I2C MULTIPLEXER DRIVER
> > @@ -9445,7 +9445,7 @@ MAX16065 HARDWARE MONITOR DRIVER
> >  M:	Guenter Roeck <linux@roeck-us.net>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/max16065
> > +F:	Documentation/hwmon/max16065.rst
> >  F:	drivers/hwmon/max16065.c
> > =20
> >  MAX2175 SDR TUNER DRIVER
> > @@ -9461,14 +9461,14 @@ F:	include/uapi/linux/max2175.h
> >  MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Orphan
> > -F:	Documentation/hwmon/max6650
> > +F:	Documentation/hwmon/max6650.rst
> >  F:	drivers/hwmon/max6650.c
> > =20
> >  MAX6697 HARDWARE MONITOR DRIVER
> >  M:	Guenter Roeck <linux@roeck-us.net>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/max6697
> > +F:	Documentation/hwmon/max6697.rst
> >  F:	Documentation/devicetree/bindings/hwmon/max6697.txt
> >  F:	drivers/hwmon/max6697.c
> >  F:	include/linux/platform_data/max6697.h
> > @@ -10118,7 +10118,7 @@ F:	drivers/mfd/menf21bmc.c
> >  F:	drivers/watchdog/menf21bmc_wdt.c
> >  F:	drivers/leds/leds-menf21bmc.c
> >  F:	drivers/hwmon/menf21bmc_hwmon.c
> > -F:	Documentation/hwmon/menf21bmc
> > +F:	Documentation/hwmon/menf21bmc.rst
> > =20
> >  MEN Z069 WATCHDOG DRIVER
> >  M:	Johannes Thumshirn <jth@kernel.org>
> > @@ -10747,7 +10747,7 @@ NCT6775 HARDWARE MONITOR DRIVER
> >  M:	Guenter Roeck <linux@roeck-us.net>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/nct6775
> > +F:	Documentation/hwmon/nct6775.rst
> >  F:	drivers/hwmon/nct6775.c
> > =20
> >  NET_FAILOVER MODULE
> > @@ -11841,7 +11841,7 @@ PC87360 HARDWARE MONITORING DRIVER
> >  M:	Jim Cromie <jim.cromie@gmail.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/pc87360
> > +F:	Documentation/hwmon/pc87360.rst
> >  F:	drivers/hwmon/pc87360.c
> > =20
> >  PC8736x GPIO DRIVER
> > @@ -11853,7 +11853,7 @@ PC87427 HARDWARE MONITORING DRIVER
> >  M:	Jean Delvare <jdelvare@suse.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/pc87427
> > +F:	Documentation/hwmon/pc87427.rst
> >  F:	drivers/hwmon/pc87427.c
> > =20
> >  PCA9532 LED DRIVER
> > @@ -12421,23 +12421,23 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
> >  F:	Documentation/devicetree/bindings/hwmon/max31785.txt
> >  F:	Documentation/devicetree/bindings/hwmon/ltc2978.txt
> > -F:	Documentation/hwmon/adm1275
> > -F:	Documentation/hwmon/ibm-cffps
> > -F:	Documentation/hwmon/ir35221
> > -F:	Documentation/hwmon/lm25066
> > -F:	Documentation/hwmon/ltc2978
> > -F:	Documentation/hwmon/ltc3815
> > -F:	Documentation/hwmon/max16064
> > -F:	Documentation/hwmon/max20751
> > -F:	Documentation/hwmon/max31785
> > -F:	Documentation/hwmon/max34440
> > -F:	Documentation/hwmon/max8688
> > -F:	Documentation/hwmon/pmbus
> > -F:	Documentation/hwmon/pmbus-core
> > -F:	Documentation/hwmon/tps40422
> > -F:	Documentation/hwmon/ucd9000
> > -F:	Documentation/hwmon/ucd9200
> > -F:	Documentation/hwmon/zl6100
> > +F:	Documentation/hwmon/adm1275.rst
> > +F:	Documentation/hwmon/ibm-cffps.rst
> > +F:	Documentation/hwmon/ir35221.rst
> > +F:	Documentation/hwmon/lm25066.rst
> > +F:	Documentation/hwmon/ltc2978.rst
> > +F:	Documentation/hwmon/ltc3815.rst
> > +F:	Documentation/hwmon/max16064.rst
> > +F:	Documentation/hwmon/max20751.rst
> > +F:	Documentation/hwmon/max31785.rst
> > +F:	Documentation/hwmon/max34440.rst
> > +F:	Documentation/hwmon/max8688.rst
> > +F:	Documentation/hwmon/pmbus.rst
> > +F:	Documentation/hwmon/pmbus-core.rst
> > +F:	Documentation/hwmon/tps40422.rst
> > +F:	Documentation/hwmon/ucd9000.rst
> > +F:	Documentation/hwmon/ucd9200.rst
> > +F:	Documentation/hwmon/zl6100.rst
> >  F:	drivers/hwmon/pmbus/
> >  F:	include/linux/pmbus.h
> > =20
> > @@ -12701,7 +12701,7 @@ M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@sams=
ung.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Supported
> >  F:	Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> > -F:	Documentation/hwmon/pwm-fan
> > +F:	Documentation/hwmon/pwm-fan.rst
> >  F:	drivers/hwmon/pwm-fan.c
> > =20
> >  PWM IR Transmitter
> > @@ -14366,21 +14366,21 @@ SMM665 HARDWARE MONITOR DRIVER
> >  M:	Guenter Roeck <linux@roeck-us.net>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/smm665
> > +F:	Documentation/hwmon/smm665.rst
> >  F:	drivers/hwmon/smm665.c
> > =20
> >  SMSC EMC2103 HARDWARE MONITOR DRIVER
> >  M:	Steve Glendinning <steve.glendinning@shawell.net>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/emc2103
> > +F:	Documentation/hwmon/emc2103.rst
> >  F:	drivers/hwmon/emc2103.c
> > =20
> >  SMSC SCH5627 HARDWARE MONITOR DRIVER
> >  M:	Hans de Goede <hdegoede@redhat.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Supported
> > -F:	Documentation/hwmon/sch5627
> > +F:	Documentation/hwmon/sch5627.rst
> >  F:	drivers/hwmon/sch5627.c
> > =20
> >  SMSC UFX6000 and UFX7000 USB to VGA DRIVER
> > @@ -14393,7 +14393,7 @@ SMSC47B397 HARDWARE MONITOR DRIVER
> >  M:	Jean Delvare <jdelvare@suse.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/smsc47b397
> > +F:	Documentation/hwmon/smsc47b397.rst
> >  F:	drivers/hwmon/smsc47b397.c
> > =20
> >  SMSC911x ETHERNET DRIVER
> > @@ -15744,7 +15744,7 @@ TMP401 HARDWARE MONITOR DRIVER
> >  M:	Guenter Roeck <linux@roeck-us.net>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/tmp401
> > +F:	Documentation/hwmon/tmp401.rst
> >  F:	drivers/hwmon/tmp401.c
> > =20
> >  TMPFS (SHMEM FILESYSTEM)
> > @@ -16796,7 +16796,7 @@ VT1211 HARDWARE MONITOR DRIVER
> >  M:	Juerg Haefliger <juergh@gmail.com>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/vt1211
> > +F:	Documentation/hwmon/vt1211.rst
> >  F:	drivers/hwmon/vt1211.c
> > =20
> >  VT8231 HARDWARE MONITOR DRIVER
> > @@ -16824,14 +16824,14 @@ W83791D HARDWARE MONITORING DRIVER
> >  M:	Marc Hulsman <m.hulsman@tudelft.nl>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/w83791d
> > +F:	Documentation/hwmon/w83791d.rst
> >  F:	drivers/hwmon/w83791d.c
> > =20
> >  W83793 HARDWARE MONITORING DRIVER
> >  M:	Rudolf Marek <r.marek@assembler.cz>
> >  L:	linux-hwmon@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/hwmon/w83793
> > +F:	Documentation/hwmon/w83793.rst
> >  F:	drivers/hwmon/w83793.c
> > =20
> >  W83795 HARDWARE MONITORING DRIVER
> > @@ -16940,7 +16940,7 @@ L:	patches@opensource.cirrus.com
> >  T:	git https://github.com/CirrusLogic/linux-drivers.git
> >  W:	https://github.com/CirrusLogic/linux-drivers/wiki
> >  S:	Supported
> > -F:	Documentation/hwmon/wm83??
> > +F:	Documentation/hwmon/wm83??.rst
> >  F:	Documentation/devicetree/bindings/extcon/extcon-arizona.txt
> >  F:	Documentation/devicetree/bindings/regulator/arizona-regulator.txt
> >  F:	Documentation/devicetree/bindings/mfd/arizona.txt
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index dedd5febd3aa..470ba66b18b0 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -17,7 +17,7 @@ menuconfig HWMON
> > =20
> >  	  To find out which specific driver(s) you need, use the
> >  	  sensors-detect script from the lm_sensors package.  Read
> > -	  <file:Documentation/hwmon/userspace-tools> for details.
> > +	  <file:Documentation/hwmon/userspace-tools.rst> for details.
> > =20
> >  	  This support can also be built as a module. If so, the module
> >  	  will be called hwmon.
> > @@ -59,7 +59,7 @@ config SENSORS_ABITUGURU
> >  	  chip can be found on Abit uGuru featuring motherboards (most modern
> >  	  Abit motherboards from before end 2005). For more info and a list
> >  	  of which motherboards have which revision see
> > -	  Documentation/hwmon/abituguru
> > +	  Documentation/hwmon/abituguru.rst
> > =20
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called abituguru.
> > @@ -73,7 +73,7 @@ config SENSORS_ABITUGURU3
> >  	  and their settings is supported. The third revision of the Abit
> >  	  uGuru chip can be found on recent Abit motherboards (since end
> >  	  2005). For more info and a list of which motherboards have which
> > -	  revision see Documentation/hwmon/abituguru3
> > +	  revision see Documentation/hwmon/abituguru3.rst
> > =20
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called abituguru3.
> > @@ -643,7 +643,7 @@ config SENSORS_CORETEMP
> >  	help
> >  	  If you say yes here you get support for the temperature
> >  	  sensor inside your CPU. Most of the family 6 CPUs
> > -	  are supported. Check Documentation/hwmon/coretemp for details.
> > +	  are supported. Check Documentation/hwmon/coretemp.rst for details.
> > =20
> >  config SENSORS_IT87
> >  	tristate "ITE IT87xx and compatibles"
> > diff --git a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
> > index e6be617e3fb2..03d6e782777a 100644
> > --- a/drivers/hwmon/ads7828.c
> > +++ b/drivers/hwmon/ads7828.c
> > @@ -8,7 +8,7 @@
> >   *
> >   * ADS7830 support, by Guillaume Roguez <guillaume.roguez@savoirfairel=
inux.com>
> >   *
> > - * For further information, see the Documentation/hwmon/ads7828 file.
> > + * For further information, see the Documentation/hwmon/ads7828.rst fi=
le.
> >   *
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of the GNU General Public License as published by
> > diff --git a/drivers/hwmon/max197.c b/drivers/hwmon/max197.c
> > index 3d9e210beedf..dd6a35219a18 100644
> > --- a/drivers/hwmon/max197.c
> > +++ b/drivers/hwmon/max197.c
> > @@ -8,7 +8,7 @@
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> >   *
> > - * For further information, see the Documentation/hwmon/max197 file.
> > + * For further information, see the Documentation/hwmon/max197.rst fil=
e.
> >   */
> > =20
> >  #include <linux/kernel.h>
> > diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
> > index 39b41e35c2bf..7f4a63959730 100644
> > --- a/drivers/hwmon/sht15.c
> > +++ b/drivers/hwmon/sht15.c
> > @@ -10,7 +10,7 @@
> >   *
> >   * Copyright (c) 2007 Wouter Horre
> >   *
> > - * For further information, see the Documentation/hwmon/sht15 file.
> > + * For further information, see the Documentation/hwmon/sht15.rst file.
> >   */
> > =20
> >  #include <linux/interrupt.h>
> > diff --git a/include/linux/platform_data/ads7828.h b/include/linux/plat=
form_data/ads7828.h
> > index 3245f45f9d77..a3370a007702 100644
> > --- a/include/linux/platform_data/ads7828.h
> > +++ b/include/linux/platform_data/ads7828.h
> > @@ -4,7 +4,7 @@
> >   * Copyright (c) 2012 Savoir-faire Linux Inc.
> >   *          Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> >   *
> > - * For further information, see the Documentation/hwmon/ads7828 file.
> > + * For further information, see the Documentation/hwmon/ads7828.rst fi=
le.
> >   *
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of the GNU General Public License version 2 as
> > diff --git a/include/linux/platform_data/ds620.h b/include/linux/platfo=
rm_data/ds620.h
> > index 6ef58bb77e46..f0ce22a78bb8 100644
> > --- a/include/linux/platform_data/ds620.h
> > +++ b/include/linux/platform_data/ds620.h
> > @@ -14,7 +14,7 @@ struct ds620_platform_data {
> >  	 *  1 =3D PO_LOW
> >  	 *  2 =3D PO_HIGH
> >  	 *
> > -	 * (see Documentation/hwmon/ds620)
> > +	 * (see Documentation/hwmon/ds620.rst)
> >  	 */
> >  	int pomode;
> >  };
> > diff --git a/include/linux/platform_data/ina2xx.h b/include/linux/platf=
orm_data/ina2xx.h
> > index 9f0aa1b48c78..dde59fd3590f 100644
> > --- a/include/linux/platform_data/ina2xx.h
> > +++ b/include/linux/platform_data/ina2xx.h
> > @@ -7,7 +7,7 @@
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> >   *
> > - * For further information, see the Documentation/hwmon/ina2xx file.
> > + * For further information, see the Documentation/hwmon/ina2xx.rst fil=
e.
> >   */
> > =20
> >  /**
> > diff --git a/include/linux/platform_data/max197.h b/include/linux/platf=
orm_data/max197.h
> > index 8da8f94ee15c..2bbd0919bc89 100644
> > --- a/include/linux/platform_data/max197.h
> > +++ b/include/linux/platform_data/max197.h
> > @@ -8,7 +8,7 @@
> >   * it under the terms of the GNU General Public License version 2 as
> >   * published by the Free Software Foundation.
> >   *
> > - * For further information, see the Documentation/hwmon/max197 file.
> > + * For further information, see the Documentation/hwmon/max197.rst fil=
e.
> >   */
> > =20
> >  #ifndef _PDATA_MAX197_H
> > diff --git a/include/linux/platform_data/ntc_thermistor.h b/include/lin=
ux/platform_data/ntc_thermistor.h
> > index ee03d429742b..5fa115d3ea4b 100644
> > --- a/include/linux/platform_data/ntc_thermistor.h
> > +++ b/include/linux/platform_data/ntc_thermistor.h
> > @@ -42,7 +42,7 @@ struct ntc_thermistor_platform_data {
> >  	 * read_uV()
> >  	 *
> >  	 * How to setup pullup_ohm, pulldown_ohm, and connect is
> > -	 * described at Documentation/hwmon/ntc_thermistor
> > +	 * described at Documentation/hwmon/ntc_thermistor.rst
> >  	 *
> >  	 * pullup/down_ohm: 0 for infinite / not-connected
> >  	 * =20



Thanks,
Mauro
