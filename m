Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 8CA9F67EB1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 17:30:34 +1000 (EST)
To: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Aug 2005 13:50:45 +0800."
	<A9DE2BAF233E444FA9C5E77A5825A01E86505D@ydmail.sbell.com.cn>
Date: Wed, 10 Aug 2005 09:30:16 +0200
Sender: wd@denx.de
Message-Id: <20050810073016.37BA5353C46@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ??: Some version different 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <A9DE2BAF233E444FA9C5E77A5825A01E86505D@ydmail.sbell.com.cn> you wrote:
>
>   It is the "r3" register data wrong transfer from ppcboot  to kernel. I
> don't know why. very strange. !!!

I'm sure that PPCBoot passes a valid pointer. If you  don;t  see  the
expected  data,  then  you  should probably go back to square one and
read the FAQ: 
http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel

>   The CONFIG_HD860 cannot be compiled in kernel. I don't know either.
> There is no error or warring during config and make.

There is a bug (at least one) n your modifications to the Linux kernel.

>    Then "Oops: kernel access of bad area, sig: 11" and stopped.
>  
>   How is the "with no serial options enabled" ? is it need any config
> with "make menuconfig" ?

I don't know your hardware.
I don't know why you are using  obsolete  versions  of  the  software
(like PPCBoot) for any current work.
I don't know which modifications you made to U-Boot to make it  work
on your hardware, or if these modifications are working at all.
I don't know which modifications you made to Linux.

I cannot help you. Hire an expert.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
There is nothing in this world constant but inconstancy.      - Swift
