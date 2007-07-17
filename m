Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 515E1DDDEB
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 15:32:19 +1000 (EST)
Subject: Re: [PATCH 0/3] 82xx: Add the support for Wind River SBC PowerQUICCII
From: Mark Zhan <rongkai.zhan@windriver.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <20070717044414.03983375@localhost.localdomain>
References: <469B33E8.8010105@windriver.com>
	<20070717044414.03983375@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 13:25:03 +0800
Message-Id: <1184649903.10499.49.camel@mark>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

When you will send out your 8xx/82xx series patches?

Thanks
Mark Zhan
On Tue, 2007-07-17 at 04:44 +0400, Vitaly Bordug wrote:
> On Mon, 16 Jul 2007 17:01:28 +0800
> Mark Zhan wrote:
> 
> > These 3 patches add the powerpc support of Wind River SBC
> > PowerQUICCII.
> > 
> I am sorry, but this would intercept with big 8xx/82xx series from 
> Scott Wood I am reviewing now. it makes the initial merged code
> more maintainable and powerpc-friendly, but would have some rework
> required in upcoming patches for new BSPs.
> 
> OTOH, it would make all the changes below very short and apparent.
> Of course, if something would block those series this one can be considered to merge.
> 
> 
> > 1) Currently, some mpc82xx platform hooks in mpc82xx_ads.c are
> > actually not specific to ads board. So the 1st patch makes them be
> > shared by different 82xx boards.
> > 
> > 2) The 2nd patch make 'cpm_uart_of_init' be able to parse SMC uart in
> > DTS
> > 
> > 3) The 3rd patch is the platform codes, defconfig and dts for Wind
> > River SBC PowerQUICCII 82xx board.
> > 
> > Any comment is welcome.
> > 
> > Thanks
> > Mark Zhan
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
