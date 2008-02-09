Return-Path: <wigyori@uid0.hu>
Received: from postahivatal.webmedia.hu (postahivatal.webmedia.hu
	[217.20.135.253]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2536ADDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Feb 2008 07:24:59 +1100 (EST)
Received: from dsl85-238-74-237.pool.tvnet.hu ([85.238.74.237]:42651
	helo=[10.1.1.2])
	by postahivatal.webmedia.hu with esmtpsa (Exim 4.63 #1 (Debian))
	id 1JNvVd-0004Y4-2Z from <wigyori@uid0.hu>
	for <linuxppc-embedded@ozlabs.org>; Sat, 09 Feb 2008 20:37:09 +0100
Message-ID: <47AE00FE.1000704@uid0.hu>
Date: Sat, 09 Feb 2008 20:37:34 +0100
From: Zoltan HERPAI <wigyori@uid0.hu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Ebony development board
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I've recently got an Ebony board (440GP) with the original bootloader 
(440GP 1.18 ROM Monitor) which I would like to replace with U-boot. Is 
there a way to boot an U-boot image via TFTP to replace the bootloader, 
or is it possible only with using a JTAG? I've googled through the 
mailing list, but most of the related hits are dated back in 2004-2005, 
they say no, one have to use JTAG, but some time passed since then, and 
I would like to know if there is a way for this.

Thanks in advance,
Zoltan HERPAI
