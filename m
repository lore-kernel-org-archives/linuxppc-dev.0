Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-119.roch.qwest.net [67.41.71.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1322667A7C
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Mar 2005 08:11:44 +1100 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Takeharu KATO <takeharu1219@ybb.ne.jp>
In-Reply-To: <422B56CD.9020708@ybb.ne.jp>
References: <4226FF62.30007@jp.fujitsu.com>
	<c56d8feba0d803d74d77ab20f54287e9@freescale.com>
	<42272B69.8000303@ybb.ne.jp>	<20050303101146.A8869@cox.net>
	<42282C83.9040707@jp.fujitsu.com>
	<1109982868.1479.22.camel@jdub.homelinux.org>
	<422969B9.6040303@ybb.ne.jp> <422B56CD.9020708@ybb.ne.jp>
Content-Type: text/plain
Date: Sun, 06 Mar 2005 15:11:36 -0600
Message-Id: <1110143496.28218.2.camel@jdub.homelinux.org>
Mime-Version: 1.0
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] WDT Driver for Book-E [2/2] Device driver part.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2005-03-07 at 04:15 +0900, Takeharu KATO wrote:
> Hi, Josh:
> 
> Takeharu KATO wrote:
> >>
> > To tell the truth, this matter has been examined, but I forgot this.
> > Thank you for making it recall(^^
> > 
> I performed minor fixes which you pointed out.
> But I leaves WDT_WP[0123] on purpose.
> The interpretation of this value is different between PPC4xx and e500.
> To unite them, I leaves this.

Ok, that makes sense.

> 
> >>
> >> In include/linux/device.h there are dev_printk and dev_dbg macros that
> >> do pretty much the same thing.  Could you use those instead?
> >>
> > I did not know such thing.
> > I'll try to use them.
> > 
> On second thought, I found that it is not so good idea.
> If I change this according to what you said, it is not
> easy to find which driver outputs messages when we can
> use multiple WDT in a system.
> 
> Macros in include/linux/device.h will use name member in miscdevice 
> struct as driver's name, and this is commonly named as "watchdog".
> 

Ok, that's fine too.  No complaints here.

> FYI, I show the difference with the patch submitted last time.
> 
> 
> Regards,I'll test this driver today, just in case, before I post the 
> revised edition of this driver.

Thanks!  Looks good.

josh
