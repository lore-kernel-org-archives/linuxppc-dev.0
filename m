Return-Path: <wei.li4@elf.mcgill.ca>
Received: from torrent.cc.mcgill.ca (torrent.cc.mcgill.ca [132.206.27.49])
	by ozlabs.org (Postfix) with ESMTP id 323DD67B7F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 04:03:03 +1000 (EST)
Received: from mailscan2.cc.mcgill.ca (mailscan2.CC.McGill.CA [132.216.77.249])
	by torrent.cc.mcgill.ca (8.12.11/8.12.3) with ESMTP id k7AI31Qh031787
	for <linuxppc-embedded@ozlabs.org>; Thu, 10 Aug 2006 14:03:01 -0400
Received: from wgrappe2.cc.mcgill.ca (wgrappe2.CC.McGill.CA [132.216.46.251])
	by mailscan2.cc.mcgill.ca (8.13.6/8.13.0) with ESMTP id
	k7AI2tCn027664 for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 14:02:55 -0400 (EDT)
Received: from wgrappe2.cc.mcgill.ca (localhost.localdomain [127.0.0.1])
	by wgrappe2.cc.mcgill.ca (8.13.4/8.13.4) with ESMTP id k7AI2tGS029532
	for <linuxppc-embedded@ozlabs.org>; Thu, 10 Aug 2006 14:02:55 -0400
Received: (from apache@localhost)
	by wgrappe2.cc.mcgill.ca (8.13.4/8.13.4/Submit) id k7AI2tbG029529
	for linuxppc-embedded@ozlabs.org; Thu, 10 Aug 2006 14:02:55 -0400
Message-ID: <20060810140255.04md0zkckksogokc@webmail.mcgill.ca>
Date: Thu, 10 Aug 2006 14:02:55 -0400
From: wei.li4@elf.mcgill.ca
To: linuxppc-embedded@ozlabs.org
Subject: Compatibility Problem between linux-2.4.25 and RedBoot
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

Hi all,

Since my evaluation board based on MPC875 is pre-installed RedBoot 
Loader and Linux with this kit can be loaded and execute, but I want to 
try public powerpc linux, which can be loaded, but not execute. Dose 
any one know how to change it so that it is compatible with RedBoot? I 
checked the definition of struct bd_info{} is different, is it the 
shared struct by bootloader and Linux? How dose loader work with linux? 
Thanks.

Wei
