Message-ID: <001501c2500d$f209f150$faffa8c0@VISHWANATH>
From: "Vishwanath" <vishwanath@mistralsoftware.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: IBM 440GP IIC driver
Date: Fri, 30 Aug 2002 15:43:54 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I am working on 440 GP board. I2C controller of 440 GP supports both 7-bit
and 10-bit addressing. But Linux supports only 7-bit addressing as of now. I
have a device which has i2c sub-addresses more than 128. So I need 10-bit
addressing of I2C controller. Apart from loading the higher bits of address
in High Address Register, is there any special thing to be taken care of,
while modifying the driver for 10-bit addressing ?

Thanks and regards,
Vishwanath


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
