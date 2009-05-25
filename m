Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 0E98DDE04E
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 06:40:38 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1M8gyI-0005hh-Kd
	for linuxppc-dev@ozlabs.org; Mon, 25 May 2009 13:40:34 -0700
Message-ID: <23712750.post@talk.nabble.com>
Date: Mon, 25 May 2009 13:40:34 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-dev@ozlabs.org
Subject: Re: U-boot and linux command line parameters
In-Reply-To: <23703397.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <23698384.post@talk.nabble.com>
	<20090525000618.GD8059@yookeroo.seuss>
	<23703397.post@talk.nabble.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I have done some experiments with u-boot (version 1.2.0) and with linux
kernel (version 2.6.23) and it seems to be that the limitation of 8MB is not
anymore the problem. I have built u-boot and linux for ppc405 (virtex-4). I
have set the CFG_BOOTMAPSZ to 16 MB:
#define CFG_BOOTMAPSZ             (8 << 21)  /* 16 MB */

and Linux has picked up the command line parameters which were set in
u-boot.

>/*
> * For booting Linux, the board info and command line data
> * have to be in the first 8 MB of memory, since this is
> * the maximum mapped by the Linux kernel during initialization.
> */
> #define CFG_BOOTMAPSZ             (8 << 20)   /* Initial Memory map for
> Linux */

-- 
View this message in context: http://www.nabble.com/U-boot-and-linux-command-line-parameters-tp23698384p23712750.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
