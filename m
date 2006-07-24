Return-Path: <raja_chidambaram82@yahoo.com>
Received: from web53608.mail.yahoo.com (web53608.mail.yahoo.com
	[206.190.37.41]) by ozlabs.org (Postfix) with SMTP id 7A16067B6C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Jul 2006 22:21:33 +1000 (EST)
Message-ID: <20060724121452.55760.qmail@web53608.mail.yahoo.com>
Date: Mon, 24 Jul 2006 05:14:52 -0700 (PDT)
From: Raja Chidambaram <raja_chidambaram82@yahoo.com>
Subject: RE:SystemAce Driver.
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
 We are working on customized board with amcc 440SPe
processor & xilinx System Ace controller. The System
Ace controller is connected to compact flash driver.

We use u-boot 1.2 as bootloader & linux kernel
2.6.16-2.

On the process the u-boot is able to detect compact
flash through Xilinx SystemAce controller & able to
load the kernel image into compact flash.But when the
linux boot's up it not able to detect the System Ace
controller or compact flash.

Note:we need to have the root file system in compact
flash.

Is their any drivers available for SystemAce
controller on linux 2.6,if their how to get it.please
help me in this
                                    with regards
                                     raja



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
