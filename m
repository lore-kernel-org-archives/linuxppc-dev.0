Return-Path: <wd@denx.de>
Received: from mailout08.sul.t-online.com (mailout08.sul.t-online.com
	[194.25.134.20]) by ozlabs.org (Postfix) with ESMTP id 4B8F8685BB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Oct 2005 06:09:08 +1000 (EST)
To: somshekar chandrashekar kadam <som_kadam1@rediffmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "17 Oct 2005 07:52:08 -0000."
	<20051017075208.29624.qmail@webmail24.rediffmail.com>
Date: Mon, 17 Oct 2005 22:08:51 +0200
Sender: wd@denx.de
Message-Id: <20051017200851.9357D352B7B@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ELDK 3.1.1 ramdisk 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20051017075208.29624.qmail@webmail24.rediffmail.com> you wrote:
>
>    I am using MPC862 with 64mb ram , with Denx 3.1.1 eldk
> with linux-2.4.25 on my custom board. 
> on Uboot i use SMC2 as my seri
> al console , when i load linux i use SCC4 as my serisl console , this is be
> cuase i dont have any idea why my SMC2 is not working , it works fine on my
>  linux-2.4.18 kernel , 
> anyways thats not the problem ,

Yes it is. It is a major mistake to ignore one problem and to try  to
continue and then complain about other, later issues.

Fix one problem at a time.

Do not try to continue before fixing the console problem.

> i am using r
> amdisk_image.gz provided by eldk , and i have configured kernel wit intial
> ramdisk support , i have attachec the config file below , and also the boot
> ing messages in another file . as i chnages the console from smc2 to scc4 f
> rom uboot to linux may be intial message is not clear , 

It is not only not clear, but unreadable. Like most of your  message,
btw. Please fix your mailer.

> i always get ker
> nel panic VFS unable to mount root fs , is there something else i need to d
> o or i am missing very important configuartion , please throw some light

Which exact boot arguments did you pass?


You configure for a MBX board - is this *really*  one  of  these  old
door stoppers?

Try removing devfs support and CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE
from your configuration.

Best regards,
Viele Grüße,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Everyting looks interesting until you do it. Then you find it's  just
another job.                     - Terry Pratchett, _Moving Pictures_
