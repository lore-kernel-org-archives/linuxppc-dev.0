Return-Path: <pevnev@juno.com>
Received: from outbound-mail.lax.untd.com (outbound-mail.lax.untd.com
	[64.136.28.164]) by ozlabs.org (Postfix) with SMTP id E296467A91
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Feb 2005 05:23:33 +1100 (EST)
Received: from outbound29-sr.lax.untd.com (webmail01.lax.untd.com
	[10.131.27.141])
	by smtpout04.lax.untd.com with SMTP id AABBAWXJ5AZ9EEBJ
	for <linuxppc-dev@ozlabs.org> (sender <pevnev@juno.com>);
	Wed,  9 Feb 2005 10:23:23 -0800 (PST)
Mime-Version: 1.0
From: "Alexander Povolotsky" <pevnev@juno.com>
Date: Wed, 9 Feb 2005 18:22:10 GMT
To: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Message-Id: <20050209.102300.2012.117453@webmail01.lax.untd.com>
Subject: question on CONFIG_I2C_SPI_UCODE_PATCH and
	CONFIG_I2C_SPI_SMC1_UCODE_P ATCH
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

I have a question on use of CONFIG_I2C_SPI_UCODE_PATCH and CONFIG_I2C_SPI_SMC1_UCODE_PATCH in Linux 2.6.

Could someone from this list explain for me what problems each of those two patches are addressing ?
I have MPC 880 based board with single 24C02 I2C EEPROM,
connected to the I2C bus and currently (without those two patches configured in .config) I have problem of communicating 
over I2C bus with that device - scanning for any address (in the range between 0 and 128) on the I2C bus does not get any response (interrupt)
so code remains in the sleep (on interrupt) mode.

Would applying (any or both) above patches resolve my problem as described ?

Thanks,
Best Regards,
Alex

___________________________________________________________________
Speed up your surfing with Juno SpeedBand.
Now includes pop-up blocker!
Only $14.95/month -visit http://www.juno.com/surf to sign up today!
