Return-Path: <nsundar@fulcrummicro.com>
Received: from smtp.fulcrummicro.com (smtp.fulcrummicro.com [66.59.247.212])
	by ozlabs.org (Postfix) with ESMTP id C757067A77
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 May 2006 00:54:11 +1000 (EST)
Received: from [10.0.0.61] (hamilcar.internal.avlsi.com [10.0.0.61])
	by smtp.fulcrummicro.com (Postfix) with ESMTP id 4F2B22A2B4E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 May 2006 07:33:12 -0700 (PDT)
Message-ID: <447711A7.5060200@fulcrummicro.com>
Date: Fri, 26 May 2006 07:33:11 -0700
From: Naru Sundar <nsundar@fulcrummicro.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: 2.6 (eldk) - I2C constants
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello folks, I'm porting a 2.4 driver over to 2.6 and noted some 
weirdness in the I2C headers.  I thought it was worth checking out here.

include/linux/i2c.h in 2.4 defined the following constants:
#define I2C_M_TEN   0x10    /* we have a ten bit chip address   */
#define I2C_M_RD    0x01
#define I2C_M_WR        0x00    /* For readable code!                   */
#define I2C_M_NOSTART   0x4000
#define I2C_M_REV_DIR_ADDR  0x2000

in ELDK 2.6 source drop I have (2.6.15), the I2C_M_WR constant was removed.

Any thoughts? I can declare that constant locally in the driver, but 
since these were standard I2C message constants I thought something
odd was up (or am I missing something obvious).

Thanks

--
Naru Sundar <nsundar@fulcrummicro.com>
Fulcrum Microsystems
http://www.fulcrummicro.com
