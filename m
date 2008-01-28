Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B899CDE15D
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 05:46:35 +1100 (EST)
Message-ID: <479E22E0.9010105@scram.de>
Date: Mon, 28 Jan 2008 19:45:52 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Bryan Wu <cooloney.lkml@gmail.com>
Subject: Re: [PATCHv3 2.6.25] i2c: adds support for i2c bus on Freescale
	CPM1/CPM2 controllers
References: <479A185D.6010406@scram.de>
	<386072610801280921q3e96bfc1v40ad09660c0f7ad8@mail.gmail.com>
In-Reply-To: <386072610801280921q3e96bfc1v40ad09660c0f7ad8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>,
	Linux I2C <i2c@lm-sensors.org>, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Bryan,

>> +
>> +       /* register new adapter to i2c module... */
>> +
>> +       result = i2c_add_adapter(&cpm->adap);
> 
> As I was pointed before, please use the new style i2c driver interface:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=991dee591a99d035796a8c194eb1796cc020e142

AFAIK, the device tree currently doesn't provide an adapter id. If we're going to add this property, this would be
needed on other of_platform i2c drivers, as well.

Thanks,
Jochen
