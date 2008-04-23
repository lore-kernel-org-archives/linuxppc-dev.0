Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA60CDE42D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 02:35:45 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3NGZe1H012748 for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 09:35:40 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m3NGZdlj000269
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 11:35:39 -0500 (CDT)
Date: Wed, 23 Apr 2008 11:35:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: ??? <yuyongbao@126.com>
Subject: Re: mpc8379e rdb nand flash support
Message-ID: <20080423163538.GA32452@ld0162-tx32.am.freescale.net>
References: <mailman.2018.1208895004.11702.linuxppc-embedded@ozlabs.org>
	<FD78E578AB254426A3B97E7B65553E65@baby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FD78E578AB254426A3B97E7B65553E65@baby>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Apr 23, 2008 at 03:47:00PM +0800, ??? wrote:
> Dear all:
>     Did anyone use mpc8379erdb board?  I changed nand flash from samsung 32M to hynix 1G byte.And the 1G byte nand's erase block size is 256KB.
>     Now the problem is: when I use " nand write.jffs2" command to write jffs2 filesystems to nand flash ,there is only 128KByte of every erase blocks can be writed.
>     From the datasheet of the mpc8379e ,"Page size of 2048 main area bytes plus 64 spare area bytes (large page devices);
> FCM RAM buffers are 4 Kbytes each; Flash block size of 128 Kbytes."
>     Is it means mpc8379e only support 128Kbytes block size?
>     Here is the information when I tried to write it :

It looks like you're talking about u-boot, not Linux; the FCM NAND driver
has not yet been merged.  Are you using a Freescale BSP?  If so, it's
best to go through official support channels.  If you're using patches
that were recently posted, make sure you have all the bugfixes that
recently went into the linux mtd tree.

-Scott
