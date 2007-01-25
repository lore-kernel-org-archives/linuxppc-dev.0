Return-Path: <jimmyzhmliu@yahoo.com>
Received: from web53101.mail.yahoo.com (web53101.mail.yahoo.com
	[206.190.49.51]) by ozlabs.org (Postfix) with SMTP id EA164DDFD0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 14:28:23 +1100 (EST)
Date: Wed, 24 Jan 2007 19:21:40 -0800 (PST)
From: jimmy liu <jimmyzhmliu@yahoo.com>
Subject: MPC8260 I2C Problem
To: embedded linuxppc <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <78452.12201.qm@web53101.mail.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I download the linux kernel 2.6.19 from
ftp://ftp.denx.de/pub/linux/ site.

When I add mpc8260 I2C driver to Linux kernel 2.6.19,
the init function looks like that
static int __init fsl_i2c_init(void)
{
	return driver_register(&fsl_i2c_driver);
}
I set the debug on, and found that the fsl_i2c_probe()
function is never called, so there is not I2C device
enabled, and the user space function
open("/dev/i2c-0",O_RDWR) always return error. I set
something wrong? Could somebody help me?




 
____________________________________________________________________________________
Get your own web address.  
Have a HUGE year through Yahoo! Small Business.
http://smallbusiness.yahoo.com/domains/?p=BESTDEAL
