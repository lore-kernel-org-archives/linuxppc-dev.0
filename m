Return-Path: <frannk_m1@yahoo.com>
Received: from web32203.mail.mud.yahoo.com (web32203.mail.mud.yahoo.com
	[68.142.207.134]) by ozlabs.org (Postfix) with SMTP id 0E09A67B98
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 11:54:54 +1000 (EST)
Message-ID: <20060825015453.8450.qmail@web32203.mail.mud.yahoo.com>
Date: Thu, 24 Aug 2006 18:54:53 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
Subject: Re: communication with i2c client
To: Ladislav "Klenoviè" <lk99336@pobox.sk>, linuxppc-embedded@ozlabs.org
In-Reply-To: <99de7cba0d63488089aa1add47109fb9@pobox.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--- Ladislav Klenoviè <lk99336@pobox.sk> wrote:

> Hi,
> I've create an i2c client and my questions is how to access it
> from userspace. This client is sitttng on adapter that  I was
> able to access via /dev interface. After the client were
> successfuly loaded and detected,
> ioctl(fd,I2C_SLAVE,...) and read/write functions didn't work
> and  error messages like "device busy" or "ioctl error" have
> occured. Also my debug messages from i2c client didn't arise
> when I am accessing 
> device only adapter's.
> How to (standardly) access a an i2c client? 
> Do I need to create an ioctl interface or exports some helper
> function for access it from user space and also from kernel
> space?  
> 
> regards,
> Ladislav.

You might get an answer here:
http://www.lm-sensors.org/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
