Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D100BDDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 22:24:41 +1100 (EST)
Message-ID: <479723CE.5020609@scram.de>
Date: Wed, 23 Jan 2008 12:23:58 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCHv2] i2c: adds support for i2c bus on Frescale CPM1/CPM2
	controllers
References: <477BEB60.4070703@scram.de>	<20080103104121.58697148.sfr@canb.auug.org.au>
	<20080123112941.23250948@hyperion.delvare>
In-Reply-To: <20080123112941.23250948@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Linux I2C <i2c@lm-sensors.org>,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jean,

> Do you have an updated patch addressing Stephen's comment?
> 
> Note: you'd rather send updates of this patch to the i2c list rather
> than LKML.

I'm currently looking at that last patches from Jon and try to make this
driver fit in there (+ the class override stuff).

Note: will do. I just subscribed to this list.

Thanks,
Jochen
