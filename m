Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F334687AB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Nov 2005 23:12:36 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EeAVL-0003vr-Dj
	for linuxppc-embedded@ozlabs.org; Mon, 21 Nov 2005 13:10:39 +0100
Received: from dsl-202-45-109-210.vic.netspace.net.au ([202.45.109.210])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 21 Nov 2005 13:10:39 +0100
Received: from ronkbox-news by dsl-202-45-109-210.vic.netspace.net.au with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 21 Nov 2005 13:10:39 +0100
To: linuxppc-embedded@ozlabs.org
From: Ron Kellam <ronkbox-news@yahoo.com>
Date: Mon, 21 Nov 2005 23:09:11 +1100
Message-ID: <vqd3o11sfl48nml0e99r5agdkaam096t99@4ax.com>
References: <20051121111704.89583.qmail@web15803.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: Re: Re : anyone used i2c-algo-8260 for the MPC8272 family?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mon, 21 Nov 2005 19:17:03 +0800 (CST), Sam Song
<samlinuxppc@yahoo.com.cn> wrote:

>What the kernel version are you talking about? 

Sorry - forgot to give details. I'm currently using denx-2.4.25.

>For 2.4.31, it worked on my custom 8248 platform.
>Sure, some porting work involved.

What sort of porting work was involved?  If you are using the CPM I2C
module and not bit-bashing, then there's very little to port  It's not
as though you have much choice in which I/O pins to use...

>As for 2.6, I also haven't made it work. I tried
>the official 2.6.13-rc3 kernel and denx-2.6.14
>kernel. Both no luck. I also want to know something 
>in this regards.

I'll be moving to 2.6.?? in a couple of weeks.  Seems I'll also stike
problems there too.

Regards,
Ron
