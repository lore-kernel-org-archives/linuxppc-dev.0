Return-Path: <jianlinz_2000@yahoo.com>
Received: from web56706.mail.re3.yahoo.com (web56706.mail.re3.yahoo.com
	[66.196.97.65]) by ozlabs.org (Postfix) with SMTP id 8ACDB67B89
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Dec 2006 12:31:46 +1100 (EST)
Date: Fri, 8 Dec 2006 17:25:03 -0800 (PST)
From: Jianlin Zeng <jianlinz_2000@yahoo.com>
Subject: reboot problem with MPC8248 based board
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <937646.80061.qm@web56706.mail.re3.yahoo.com>
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

I have a MPC8248 based board running with linux kernel
2.6.11. I mounted jffs2 FS on a NOR flash devices. The
jffs2 FS works fine. But whenever I modify any files
in jffs2 FS and soft reboot the board, the reboot
hangs. If I don't modify any files in jffs2 FS and
just do flashcp to mtd char device, the soft reboot
works fine.

I tried doing "reboot" through "m8260_gorom" or a
mechanism similar to what is used in u-boot. The
result is the same. I don't understand why jffs2 write
causes reboot to hang but MTD char device write does
not. Does anybody have similar experience? Can anybody
give me some help?

Thanks,
Jianlin


 
____________________________________________________________________________________
Need a quick answer? Get one in minutes from people who know.
Ask your question on www.Answers.yahoo.com
