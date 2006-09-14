Return-Path: <wei.li4@elf.mcgill.ca>
Received: from torrent.cc.mcgill.ca (torrent.cc.mcgill.ca [132.206.27.49])
	by ozlabs.org (Postfix) with ESMTP id 2EF2967B5F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 04:15:57 +1000 (EST)
Received: from mailscan2.cc.mcgill.ca (mailscan2.CC.McGill.CA [132.216.77.249])
	by torrent.cc.mcgill.ca (8.12.11/8.12.3) with ESMTP id k8EIFtLb016999
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Sep 2006 14:15:55 -0400
Received: from wgrappe2.cc.mcgill.ca (wgrappe2.CC.McGill.CA [132.216.46.251])
	by mailscan2.cc.mcgill.ca (8.13.6/8.13.0) with ESMTP id
	k8EIFomQ001969 for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 14:15:50 -0400 (EDT)
Received: from wgrappe2.cc.mcgill.ca (localhost.localdomain [127.0.0.1])
	by wgrappe2.cc.mcgill.ca (8.13.7/8.13.4) with ESMTP id k8EIFoK2001062
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Sep 2006 14:15:50 -0400
Received: (from apache@localhost)
	by wgrappe2.cc.mcgill.ca (8.13.7/8.13.7/Submit) id k8EIFo17001059
	for linuxppc-embedded@ozlabs.org; Thu, 14 Sep 2006 14:15:50 -0400
Message-ID: <20060914141550.b4x2d2aqck48osk4@webmail.mcgill.ca>
Date: Thu, 14 Sep 2006 14:15:50 -0400
From: wei.li4@elf.mcgill.ca
To: linuxppc-embedded@ozlabs.org
Subject: Uncompressing Linux failure
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

I got the following error when I ported linux 2.6.18-rc2-g73a589b5 to 
my board(MPC875), my bootloader is working fine with linux 2.6.13, and 
I am using same cross-tools from ELDK 4.0:

loaded at:     00400000 00529124
board data at: 00FFFEA8 00FFFF2C
relocated to:  00404068 004040EC
zimage at:     00404EE1 00526337
avail ram:     0052A000 01000000
                                                                        
         Uncompressing Linux...inflate returned FFFFFFFE
exit

Can you advise me? thanks.

Wei
