Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 1072E2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Dec 2004 03:31:27 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A6473AF@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Sam Song'" <samlinuxppc@yahoo.com.cn>
Date: Fri, 17 Dec 2004 11:30:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Cc: "'Demke, Torsten'" <Torsten.Demke@fci.com>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>,
	'Steven Blakeslee' <BlakesleeS@embeddedplanet.com>
Subject: 2.6.10-rc3 for 8xx with I2C config enabled  still fails ...
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

Even so much "touted" ;-) 2.6.10-rc3 FAILS for 8xx with I2C config enabled 
... and our custom MPC885 based board is using a single 24C02 type I2C
EEPROM, connected to the I2C bus ...

Does anyone of you has any input/experience about 2.6.10-rc3 functionality
(this all relates to our card) of:
SPI, HDLC, Entropia, Legerity, watchdog, NAND flash support,
MTD with JFFS2 filesystem support and flash compatibility ??? (Any info will
be much appreciated !)

Thanks,
Alex
****************************************************************
CONFIG_8xx=y
............
............
CONFIG_MTD=y
............
CONFIG_HDLC=y
............
CONFIG_PPP=y
............
CONFIG_I2C=y
...............
  CC      drivers/i2c/busses/i2c-rpx.o
drivers/i2c/busses/i2c-rpx.c:20:32: linux/i2c-algo-8xx.h: No such file or
directory
drivers/i2c/busses/i2c-rpx.c:26: warning: "struct i2c_algo_8xx_data"
declared inside parameter list
drivers/i2c/busses/i2c-rpx.c:26: warning: its scope is only this definition
or declaration,
which is probably not what you want
drivers/i2c/busses/i2c-rpx.c: In function `rpx_iic_init':
drivers/i2c/busses/i2c-rpx.c:34: error: dereferencing pointer to incomplete
type
drivers/i2c/busses/i2c-rpx.c:38: error: dereferencing pointer to incomplete
type
drivers/i2c/busses/i2c-rpx.c:38: error: dereferencing pointer to incomplete
type
drivers/i2c/busses/i2c-rpx.c:39: error: dereferencing pointer to incomplete
type
drivers/i2c/busses/i2c-rpx.c:39: error: dereferencing pointer to incomplete
type
drivers/i2c/busses/i2c-rpx.c:41: error: dereferencing pointer to incomplete
type
drivers/i2c/busses/i2c-rpx.c:42: error: dereferencing pointer to incomplete
type
drivers/i2c/busses/i2c-rpx.c:53: error: dereferencing pointer to incomplete
type
drivers/i2c/busses/i2c-rpx.c:56: error: dereferencing pointer to incomplete
type
drivers/i2c/busses/i2c-rpx.c: At top level:
drivers/i2c/busses/i2c-rpx.c:67: error: variable `rpx_data' has initializer
but
incomplete type
drivers/i2c/busses/i2c-rpx.c:68: error: unknown field `setisr' specified in
initializer
drivers/i2c/busses/i2c-rpx.c:69: warning: excess elements in struct
initializer
drivers/i2c/busses/i2c-rpx.c:69: warning: (near initialization for
`rpx_data')
drivers/i2c/busses/i2c-rpx.c: In function `i2c_rpx_init':
drivers/i2c/busses/i2c-rpx.c:83: warning: passing arg 1 of `rpx_iic_init'
from incompatible pointer type
drivers/i2c/busses/i2c-rpx.c:85: warning: implicit declaration of function
`i2c_8xx_add_bus'
drivers/i2c/busses/i2c-rpx.c: In function `i2c_rpx_exit':
drivers/i2c/busses/i2c-rpx.c:95: warning: implicit declaration of function
`i2c_8xx_del_bus'
drivers/i2c/busses/i2c-rpx.c: At top level:
drivers/i2c/busses/i2c-rpx.c:67: error: storage size of `rpx_data' isn't
known
make[3]: *** [drivers/i2c/busses/i2c-rpx.o] Error 1
make[2]: *** [drivers/i2c/busses] Error 2
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2
-----Original Message-----
From: Sam Song [mailto:samlinuxppc@yahoo.com.cn]
Sent: Friday, December 17, 2004 5:32 AM
To: Povolotsky, Alexander; 'linuxppc-embedded@ozlabs.org'
Subject: Re: Error cross-building Linux 2.6 for 8xx
