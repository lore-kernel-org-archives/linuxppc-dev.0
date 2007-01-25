Return-Path: <jimmyzhmliu@yahoo.com>
Received: from web53102.mail.yahoo.com (web53102.mail.yahoo.com
	[206.190.49.52]) by ozlabs.org (Postfix) with SMTP id 7AAD6DDFE8
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 14:18:02 +1100 (EST)
Date: Wed, 24 Jan 2007 19:11:19 -0800 (PST)
From: jimmy liu <jimmyzhmliu@yahoo.com>
Subject: mpc8260 I2C driver help
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <30640.52745.qm@web53102.mail.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I download the linux kernel 2.6.19 from
ftp://ftp.denx.de/pub/linux/ site.
When I add mpc8260 I2C driver to Linux kernel 2.6.19,
the init function like that
static int __init fsl_i2c_init(void)
{
	return driver_register(&fsl_i2c_driver);
}
but, the fsl_i2c_probe() function is never called, So
the user space function open("/dev/i2c-0",O_RDWR)
always return error. I set something wrong?



Jimmy Zhimin Liu
mailto:jimmyzhmliu@yahoo.com
www.edgar-online.com
11200 Rockville Pike, Suite 301
Rockville, MD 20874
(301)287-0339(O)
(202)499-6822(H)


 
____________________________________________________________________________________
Never Miss an Email
Stay connected with Yahoo! Mail on your mobile.  Get started!
http://mobile.yahoo.com/services?promote=mail
