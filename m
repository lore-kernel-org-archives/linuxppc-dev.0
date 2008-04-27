Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5DC3DDDDEE
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Apr 2008 21:06:09 +1000 (EST)
Message-ID: <48145E7B.6040805@scram.de>
Date: Sun, 27 Apr 2008 13:07:39 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH1/7] i2c: Add support for device alias names
References: <47FF70A7.5070002@scram.de>
	<20080426223815.16e38a85@hyperion.delvare>
In-Reply-To: <20080426223815.16e38a85@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Kernel, Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jean,

>> -	if ((err = f75375_probe(client)) < 0)
>> +	err = f75375_probe(client, NULL);
>> +	if (err < 0)
>>  		goto exit_detach;
>>  
>>  	return 0;
> 
> These coding style cleanups don't belong to this patch (if they belong
> anywhere - I don't much see the point)

I just wanted to make sure, scripts/checkpatch.pl doesn't complain.
But you're right. The coding style cleanup should have been another patch.

Thanks a lot for your efforts of getting the alias stuff in!

Jochen
