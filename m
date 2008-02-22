Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A1251DDE10
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 22:19:53 +1100 (EST)
Message-ID: <47BEAF00.50106@scram.de>
Date: Fri, 22 Feb 2008 12:16:16 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCHv4 2.6.25] i2c: adds support for i2c bus on Freescale
	CPM1/CPM2 controllers
References: <47A1C4E9.4000003@scram.de>
	<20080221130520.12b01553@hyperion.delvare>
In-Reply-To: <20080221130520.12b01553@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	i2c@lm-sensors.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jean,

>> +/*
>> + * Wait for patch from Jon Smirl
>> + * #include "powerpc-common.h"
>> + */
> 
> It doesn't make sense to merge this comment upstream.

I know you don't like the patch from Jon Smirl and you also explained your reasons.
Fortunately, I2c no longer uses numeric device IDs but names. So what are the alternatives?

1. modify the I2c subsystem to accept OF names additionally to I2c names (proposed by Jon smirl).
2. record the I2c name in the dts tree, either as seperate tag (like linux,i2c-name="<i2c-name>")
   or as additional compatible entry (like compatible="...", "linux,<i2c-name>").
3. use a glue layer with a translation map.

What is the preferred way to do this?

Thanks,
Jochen
