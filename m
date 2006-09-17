Return-Path: <junijoseph@yahoo.co.in>
Received: from web8407.mail.in.yahoo.com (web8407.mail.in.yahoo.com
	[202.43.219.155]) by ozlabs.org (Postfix) with SMTP id 56D1767B63
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Sep 2006 09:08:05 +1000 (EST)
Message-ID: <20060917230124.51672.qmail@web8407.mail.in.yahoo.com>
Date: Mon, 18 Sep 2006 00:01:24 +0100 (BST)
From: agnel juni <junijoseph@yahoo.co.in>
Subject: 440SPe - Linux 2.6 xilinx System ACE driver 
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1151876025-1158534084=:46221"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1151876025-1158534084=:46221
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello all

We are working on a 440SPe based custom board.We are trying to port the Xilinx Ssytem ACe driver onto this platform, since we need to have access to the Compact Flash to load the File system.

We validated the hardware by reading the Compact Flash through the System ACE controller from u-boot.But we find difficulties from the kernel.

We applied the system ACE driver patch onto linux-2.6.16-2.

We tried in both polling and interrupt mode.

Following are the main changes we did in the driver:

1. System ACE controller base address configuration (xparameters_ml300.h, adapter.c)
2. Endianess (xsysace_l.c)
3. IRQ (xparameters_ml300.h)


With these changes we are able to read/write to the compact flash controller.
But we see difficulties while reading the compact flash.

'Fdisk' command lists the partition details  first time we run the command. While issuing the Issuing the command second time, it exits to the command prompt without displaying the partitions.


Also we coudn't succeed in mounting the system.

Could someone give us some pointers to debug in this issue.


Thanks
Junita

 				
---------------------------------
 Find out what India is talking about on  - Yahoo! Answers India 
 Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. Get it NOW
--0-1151876025-1158534084=:46221
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello all<br><br>We are working on a 440SPe based custom board.We are trying to port the Xilinx Ssytem ACe driver onto this platform, since we need to have access to the Compact Flash to load the File system.<br><br>We validated the hardware by reading the Compact Flash through the System ACE controller from u-boot.But we find difficulties from the kernel.<br><br>We applied the system ACE driver patch onto linux-2.6.16-2.<br><br>We tried in both polling and interrupt mode.<br><br>Following are the main changes we did in the driver:<br><br>1. System ACE controller base address configuration (xparameters_ml300.h, adapter.c)<br>2. Endianess (xsysace_l.c)<br>3. IRQ (xparameters_ml300.h)<br><br><br>With these changes we are able to read/write to the compact flash controller.<br>But we see difficulties while reading the compact flash.<br><br>'Fdisk' command lists the partition details&nbsp; first time we run the command. While issuing the Issuing the command second time, it exits
 to the command prompt without displaying the partitions.<br><br><br>Also we coudn't succeed in mounting the system.<br><br>Could someone give us some pointers to debug in this issue.<br><br><br>Thanks<br>Junita<br><p>&#32;
	

	
		<hr size=1></hr> 
Find out what India is talking about on  - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers India</a> <BR> 
Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. <a href="http://us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com">Get it NOW</a>
--0-1151876025-1158534084=:46221--
