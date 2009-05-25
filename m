Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 274F8DDFF2
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 18:41:29 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1M8VkL-0000Xg-J5
	for linuxppc-dev@ozlabs.org; Mon, 25 May 2009 01:41:25 -0700
Message-ID: <23703397.post@talk.nabble.com>
Date: Mon, 25 May 2009 01:41:25 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-dev@ozlabs.org
Subject: Re: U-boot and linux command line parameters
In-Reply-To: <20090525000618.GD8059@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <23698384.post@talk.nabble.com>
	<20090525000618.GD8059@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Thank you for your answer. When studying the u-boot source code I have found
that 
it is indeed register r6 and r7 which pass the location of the command line
parameters and the
size. 

The location of the parameters could be changed in u-boot according to the
macro:
CFG_BOOTMAPSZ

There is however the message in all configuration files for u-boot that
Linux can only map first initial 8MB
so it seems to be not possible to set CFG_BOOTMAPSZ to something higher than
8MB?

/*
 * For booting Linux, the board info and command line data
 * have to be in the first 8 MB of memory, since this is
 * the maximum mapped by the Linux kernel during initialization.
 */
#define CFG_BOOTMAPSZ             (8 << 20)   /* Initial Memory map for
Linux */
 

Does somebody have an idea how to bypass this limitation in linux 2.6.23 or
higher?

M.




-- 
View this message in context: http://www.nabble.com/U-boot-and-linux-command-line-parameters-tp23698384p23703397.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
