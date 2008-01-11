Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 61BAEDE09B
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 03:05:43 +1100 (EST)
Message-ID: <478793BF.4070709@scram.de>
Date: Fri, 11 Jan 2008 17:05:19 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH 0/5] Version 17,	series to add device tree naming
	to i2c
References: <20071220044136.20091.70984.stgit@terra.home>	<20080111095638.775670ed@hyperion.delvare>
	<9e4733910801110752k57f1fd7crd5f143900fc64f0b@mail.gmail.com>
In-Reply-To: <9e4733910801110752k57f1fd7crd5f143900fc64f0b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

>>> The following series implements standard linux module aliasing for i2c modules on arch=powerpc. It then converts the mpc i2c driver from being a platform driver to an open firmware one. I2C device names are picked up from the device tree. Module aliasing is used to translate from device tree names into to linux kernel names. Several i2c drivers are updated to use the new aliasing.

>> Now that I have read all the previous versions of this patch series
>> and, more importantly, all objections that were raised on the way, I
>> can start reviewing the latest iteration of your patches. I'll also do
>> some testing, although I have no powerpc stuff here, but at least I
>> want to make sure that there are no regressions introduced by your
>> patches on x86.

> Various people were worried about x86. Around version 15 I altered the
> patches so that they only impacted PowerPC. If they impact x86 in
> current form that is a bug.

I can only second this. The latest version of i2c-cpm
(http://patchwork.ozlabs.org/linuxppc/patch?person=1023&id=15902) makes
use of this patch, as well. On the dbox2, loading and unloading of
modules in any order just works fine.

Thanks,
Jochen
