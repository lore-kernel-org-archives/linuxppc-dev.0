Return-Path: <jimmyzhmliu@yahoo.com>
Received: from web53115.mail.yahoo.com (web53115.mail.yahoo.com
	[206.190.49.65]) by ozlabs.org (Postfix) with SMTP id 92635DE016
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 15:56:19 +1100 (EST)
Message-ID: <20070125045617.40490.qmail@web53115.mail.yahoo.com>
Date: Wed, 24 Jan 2007 20:56:17 -0800 (PST)
From: jimmy liu <jimmyzhmliu@yahoo.com>
Subject: [PATCH]	I2C:	Add I2C support for the MPC8260
To: hs@denx.de, linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When I add mpc8260 I2C driver to Linux Kernel 2.6.19,
the init function looks like that
 static int __init fsl_i2c_init(void)
 {
  return driver_register(&fsl_i2c_driver);
 }

I set the debug on, and found that the fsl_i2c_probe()
function is never 
called, so there is not I2C device enabled, and the
user space function 
open("/dev/i2c-0",O_RDWR) always return error. I set
something wrong?



 
____________________________________________________________________________________
Have a burning question?  
Go to www.Answers.yahoo.com and get answers from real people who know.
