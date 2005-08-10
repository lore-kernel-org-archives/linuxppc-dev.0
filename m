Return-Path: <wd@denx.de>
Received: from mailout07.sul.t-online.com (mailout07.sul.t-online.com
	[194.25.134.83]) by ozlabs.org (Postfix) with ESMTP id 1F1EC67E98
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 15:25:48 +1000 (EST)
To: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Aug 2005 09:39:12 +0800."
	<A9DE2BAF233E444FA9C5E77A5825A01E86505B@ydmail.sbell.com.cn>
Date: Wed, 10 Aug 2005 07:25:23 +0200
Sender: wd@denx.de
Message-Id: <20050810052523.8DC79353C46@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Some version different 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <A9DE2BAF233E444FA9C5E77A5825A01E86505B@ydmail.sbell.com.cn> you wrote:
> >
>  I want to ask some questions about the different version:
>   1. The linuxppc_2_4_devel   and   the linux-2.4.25.tar.bz2 in ELDK
> 3.1.1 package

THe traball is a snapshot from the linuxppc_2_4_devel CVS  tree  (for
ELDK  3.1.1  the  date  of  the  snapshot  is  2005-03-06  or CVS tag
LABEL_2005_03_06_0100).

>   2.  The ppcboot 0.9.2 compiled with mvstia devrock   and    the
> U-Boot 1.1.2 compiled  with ELDK

PPCBoot 0.9.2 and U-Boot 1.1.2 are about 4 years apart. This is  like
comparing Linux kernel versions 2.0 with 2.6 ....

>   Does the kernel freeze at "transferring control to linux" could be
> these different versions? 

Both versions were perfectly  capable  of  booting  a  working  Linux
kernel. I don't know the MV toolchain, but I guess it's working fine,
too.  So my guess is that it's your port of the Linux kernel which is
broken.

>   1 why I configed the kernel with CONFIG_HD860 in "make menuconfig" but
> the code in CONFIG_HD860 
>      isn't compiled at all ! What's the perhaps reasons? I checked the

Your port of the Linux kernel is broken.  Probably  you  made  errors
when changing the configure scripts and/or Makefiles.

>    2  How to get board info "struct bd_info" in init/main.c ? I want to
> use printf of bd_t->bi_mon_fnc->printf() to 

You cannot do that. It does not work.

>        print some string on console. Does it possible? But the code is
> only in head_8xx.S, How to get the bd* data in 

The _res pointer can be used for that; see the existing driver sources.

>        main.c ? Some board use get_board_info(). But how can I use it? 

This depends on how your hardware and your port of Linux support such
a feature. I cannot answer such a question.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"The POP3 server service depends on the SMTP  server  service,  which
failed to start because of the following error: The operation comple-
ted successfully."                         -- Windows NT Server v3.51
