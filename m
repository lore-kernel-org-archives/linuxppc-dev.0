Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BA8DEDDE0D
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 20:58:30 +1100 (EST)
Message-ID: <476CDFEC.1070506@scram.de>
Date: Sat, 22 Dec 2007 10:59:08 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH POWERPC] i2c: adds support for i2c bus on Frescale
	CPM1/CPM2 controllers
References: <476C15BC.3090807@scram.de>
	<20071222001112.691b80c8@kernel.crashing.org>
In-Reply-To: <20071222001112.691b80c8@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	khali@linux-fr.org, linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

> I had an attempt a while ago to do this but haven't had enough time to get it completed, so
> I am glad to see it finally picked up. There was some sort of discussion that time, you seem to have some of those points
> addressed but  something not, please
> check: http://lkml.org/lkml/2007/5/8/45
>
> (for instance, cpm_i2c_shutdown() and i2c_cpm_del_bus() are void because they cant' fail)
>   

I'll resend a fixed patch.

> Also, why this was directed to Scott? This is lm-sensors stuff and is
> Jean Delvare <khali@linux-fr.org> material..

Scott reviewed this driver last time and i hope to get some further 
comments from him. But thanks for adding
Jean as well.

Thanks,
Jochen
