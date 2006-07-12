Return-Path: <wei.li4@elf.mcgill.ca>
Received: from deluge.cc.mcgill.ca (deluge.CC.McGill.CA [132.206.27.50])
	by ozlabs.org (Postfix) with ESMTP id 57F1467B84
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jul 2006 00:17:28 +1000 (EST)
Received: from drizzle.cc.mcgill.ca (drizzle.CC.McGill.CA [132.206.27.48])
	by deluge.cc.mcgill.ca (8.13.6/8.12.3) with ESMTP id k6CEBU24009921
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 10:11:30 -0400 (EDT)
Received: from mailscan5.CC.McGill.CA (mailscan5.CC.McGill.CA [132.216.77.252])
	by drizzle.cc.mcgill.ca (8.12.11/8.12.3) with ESMTP id k6CEBR5S002425
	for <linuxppc-embedded@ozlabs.org>; Wed, 12 Jul 2006 10:11:27 -0400
Received: from wgrappe3.cc.mcgill.ca (wgrappe3.CC.McGill.CA [132.216.46.252])
	by mailscan5.CC.McGill.CA (8.12.11/8.12.11) with ESMTP id
	k6CEB4eY012741
	for <linuxppc-embedded@ozlabs.org>; Wed, 12 Jul 2006 10:11:04 -0400
Received: from wgrappe3.cc.mcgill.ca (localhost.localdomain [127.0.0.1])
	by wgrappe3.cc.mcgill.ca (8.13.4/8.13.4) with ESMTP id k6CEB4kX026489
	for <linuxppc-embedded@ozlabs.org>; Wed, 12 Jul 2006 10:11:04 -0400
Received: (from apache@localhost)
	by wgrappe3.cc.mcgill.ca (8.13.4/8.13.4/Submit) id k6CEB3lT026486
	for linuxppc-embedded@ozlabs.org; Wed, 12 Jul 2006 10:11:03 -0400
Message-ID: <20060712101103.2whud1piscs4gwok@webmail.mcgill.ca>
Date: Wed, 12 Jul 2006 10:11:03 -0400
From: wei.li4@elf.mcgill.ca
To: linuxppc-embedded@ozlabs.org
Subject: Compatibility Problem between linux-2.4.25 and RedBoot
References: <mailman.1562.1152709667.11183.linuxppc-embedded@ozlabs.org>
In-Reply-To: <mailman.1562.1152709667.11183.linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I am working on AdderII-MPC875 evaluation board(preinstalled RedBoot 
Monitor) with Linux OS, I can use adderII_defconfig(in linux-2.4.25) to 
compile and link to build up the image, and I can load it at 
0x00380000, but it can't be executed. If I use its original image 
coming with this board, it seems to relocate to another address from 
0x00380000, and then decompress, execute, so is there anyone who can 
help me figure it out? any suggestion? Thanks.

Wei
