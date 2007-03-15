Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E50B7DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 17:08:25 +1100 (EST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l2F68MCc010300
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 15:08:22 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id l2F68MNa013500
	for linuxppc-dev@ozlabs.org; Thu, 15 Mar 2007 15:08:22 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l2F68LsI011054
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 15:08:21 +0900 (JST)
Message-Id: <200703150608.l2F68J1M018874@toshiba.co.jp>
MIME-Version: 1.0
Date: Thu, 15 Mar 2007 15:10:20 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: (Your message of "Thu, 15 Mar 2007 05:36:07 +0000")
	<20070315053607.GQ4095@ftp.linux.org.uk>
References: <E1HRPb0-0003Eh-OG@ZenIV.linux.org.uk>
	<200703150523.l2F5NelE001987@toshiba.co.jp>
	<20070315053607.GQ4095@ftp.linux.org.uk>
Subject: Re: [PATCH 10/13] BLK_DEV_IDE_CELLEB dependency fix
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Al wrote:
>
>Eh...  You still need dependency on IDE=y; otherwise you'll get configs
>with IDE=m, BLK_DEV_IDE_CELLEB=y and those won't link.  BLK_DEV_IDEDMA_PCI
>is selectable just fine with IDE=m.
>
>It's the same problem as with ps3 fb.
>

I'm sorry I missed this case.
Using some configurations, I found BLK_DEV_IDE=y was better.
(I failed to link when IDE=y and BLK_DEV_IDE=m.)


Best regards,
Akira Iguchi
