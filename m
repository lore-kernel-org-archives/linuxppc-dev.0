Return-Path: <pevnev@juno.com>
Received: from outbound-mail.lax.untd.com (outbound-mail.lax.untd.com
	[64.136.28.164]) by ozlabs.org (Postfix) with SMTP id D52C167A30
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 23:50:44 +1100 (EST)
Received: from outbound29-sr.lax.untd.com (webmail17.lax.untd.com
	[10.131.27.157])
	by smtpout03.lax.untd.com with SMTP id AABBABUX7AUVL2A2
	for <linuxppc-embedded@ozlabs.org> (sender <pevnev@juno.com>);
	Wed,  2 Feb 2005 04:42:37 -0800 (PST)
Mime-Version: 1.0
From: "Alex" <pevnev@juno.com>
Date: Wed, 2 Feb 2005 12:42:05 GMT
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Message-Id: <20050202.044222.25841.77117@webmail17.lax.untd.com>
Subject: 2.6.10-rc3 8xx (MPC 880) i2c driver - "about to sleep" 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

Sorry for bothering you  again - I will appreciate your opinion/advise/guidance !

What is your interpretation of entries I found in the log buf with regards to I2C driver ? 
.....
<6>i2c /dev entries driver.
<7>device class 'i2c-dev': registering.
<7>bus i2c:add driver dev_driver.
<7>i2c-core: driver dev_driver registered
<6>i2c-rpx: i2c MPC8xx driver.
<7>DEV: registering device: ID ='i2c-0'.
<7>CLASS: registering class device: ID= 'i2c-0'.
<7>i2c_adapter i2c-0:Registered as minor 0.
<7>CLASS:registering class device: ID = 'i2c-0'
<7>i2c_adapter i2c-0: registered as adapter #0.
<4>cpm_iic_init() - iip=fa203c80.
<4>cpm_iic_init[132] Install ISR for IRQ 16.
<6>CPM interrupt c0105d90 replacing c01f7a8c.
<3>request_irq() returned -22  for CPM vector 32.
<6> i2c-algo-8xx.o: scanning bus m8xx........
<4>cpm_iic_tryaddress(cpm=c019b9f8,addr=0).
<4>iip fa203c80, dp_addr 0x800.
<4>iic_tbase 2048, r_tbase 2048
<4>about to sleep
........
BOOTING HANGS FROM HERE !!!!

The board is equipped with M24Cxx-x Serial I2C bus EEPROM 
- does above means that the EEPROM device was not detected on the I2C bus ?
Do I need to supply in the code the addresses to be scanned ?

Thanks,
Alex


___________________________________________________________________
Speed up your surfing with Juno SpeedBand.
Now includes pop-up blocker!
Only $14.95/month -visit http://www.juno.com/surf to sign up today!



___________________________________________________________________
Speed up your surfing with Juno SpeedBand.
Now includes pop-up blocker!
Only $14.95/month -visit http://www.juno.com/surf to sign up today!
