Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4261CDDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 10:44:26 +1000 (EST)
Date: Tue, 17 Jul 2007 04:44:14 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Mark Zhan <rongkai.zhan@windriver.com>
Subject: Re: [PATCH 0/3] 82xx: Add the support for Wind River SBC PowerQUICCII
Message-ID: <20070717044414.03983375@localhost.localdomain>
In-Reply-To: <469B33E8.8010105@windriver.com>
References: <469B33E8.8010105@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 16 Jul 2007 17:01:28 +0800
Mark Zhan wrote:

> These 3 patches add the powerpc support of Wind River SBC
> PowerQUICCII.
> 
I am sorry, but this would intercept with big 8xx/82xx series from 
Scott Wood I am reviewing now. it makes the initial merged code
more maintainable and powerpc-friendly, but would have some rework
required in upcoming patches for new BSPs.

OTOH, it would make all the changes below very short and apparent.
Of course, if something would block those series this one can be considered to merge.


> 1) Currently, some mpc82xx platform hooks in mpc82xx_ads.c are
> actually not specific to ads board. So the 1st patch makes them be
> shared by different 82xx boards.
> 
> 2) The 2nd patch make 'cpm_uart_of_init' be able to parse SMC uart in
> DTS
> 
> 3) The 3rd patch is the platform codes, defconfig and dts for Wind
> River SBC PowerQUICCII 82xx board.
> 
> Any comment is welcome.
> 
> Thanks
> Mark Zhan
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


-- 
Sincerely, Vitaly
