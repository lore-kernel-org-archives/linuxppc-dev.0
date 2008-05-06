Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6590DDE34A
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 04:39:49 +1000 (EST)
Message-ID: <4820A5E9.8030204@scram.de>
Date: Tue, 06 May 2008 20:39:37 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] [POWERPC] Fix of_i2c include for module compilation
References: <481C5DD0.5090503@scram.de>
	<18462.35282.374180.770237@cargo.ozlabs.ibm.com>
In-Reply-To: <18462.35282.374180.770237@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>,
	Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

>> -#ifdef CONFIG_OF_I2C
>> +#if defined(CONFIG_OF_I2C) || defined(CONFIG_OF_I2C_MODULE)
>>  
>>  void of_register_i2c_devices(struct i2c_adapter *adap,
>>  			     struct device_node *adap_node);
> 
> Why do we have that ifdef there at all?  There's only that one
> external declaration within it, so the #ifdef and #endif could just be
> removed.  If the ifdef hadn't been there in the first place we
> wouldn't have had this problem.

You're right. I mainly copied from of_gpio.h without too much thinking :(.
I'll resend.

Thanks,
Jochen
