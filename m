To: GOTZON ASTONDOA <gastondoa@fagorautomation.es>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Just a little compilation error if i2c like NO module 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Sep 2002 13:56:56 +0200."
             <CA78D1B723D8D411AF0300508BDCF74FD5BC75@NTCORREO>
Date: Thu, 12 Sep 2002 14:19:06 +0200
Message-Id: <20020912121911.51120FA8D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <CA78D1B723D8D411AF0300508BDCF74FD5BC75@NTCORREO> you wrote:
>
> 	I have the kernel version 2.4.4 of 2001-7-23
> 	I try to compile i2c like no module and i find that it has problems.
> 	In drivers/i2c/i2c-simple.c (lines 48 to 59):

Which sort of problems do you encounter? We  use  this  a  statically
linked driver all the time, and it works well.

And it should, since "CONFIG_MODVERSIONS" will not be dfined with the
value of 1 if you don't compile as module.

> 		/*
> 		* Deal with CONFIG_MODVERSIONS
> 		 */
> 		#if CONFIG_MODVERSIONS==1
> 		/* # define MODVERSIONS */
> 		# include <linux/modversions.h>
> 		#endif
>
> 		#ifdef MODULE
> 		MODULE_AUTHOR("Wolfgang Denk, wd@denx.de");
> 		MODULE_DESCRIPTION("Simple I2C Driver for LWMON Project");
> 		#endif	/* MODULE */

Which sort of development tools are you using?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I have often regretted my speech, never my silence.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
