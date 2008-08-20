Return-Path: <lk.atwork@yahoo.com>
Received: from n76.bullet.mail.sp1.yahoo.com (n76.bullet.mail.sp1.yahoo.com
	[98.136.44.48]) by ozlabs.org (Postfix) with SMTP id CC220DE32A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Aug 2008 09:30:37 +1000 (EST)
Date: Wed, 20 Aug 2008 16:24:46 -0700 (PDT)
From: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: porting linux 2.6.27 to embedded powerpc board
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1932266656-1219274686=:49343"
Message-ID: <424724.49343.qm@web46312.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1932266656-1219274686=:49343
Content-Type: text/plain; charset=us-ascii

Hi,

I have an embedded PowerPC (MPC8347) board that works fine with uboot and Linux 2.6.15.

I am trying to upgrade the kernel so that it runs on the latest release - Linux 2.6.27.
So far, I have gotten the kernel to compile on my platform, but of course it does not boot.

Things have changed drastically since 2.6.15 and the porting methodology used back then is obsolete now. Progress is a good thing :-) I have googled for info on how to accomplish this port but have found nothing so far. In particular, the fact that I am using uboot instead of open firmware makes the task a bit more daunting.

The file Documentation/powerpc/booting-without-of.txt gives some info on the flattened device tree and and at the end of the "board support" section it states "I will describe later the boot process and various callbacks that your platform should implement." but that description is not  part of the document.

I am wondering where I can find more info that will help me accomplish this port.

thanks a lot for your help.
L.K


      
--0-1932266656-1219274686=:49343
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div>Hi,<br><br>I have an embedded PowerPC (MPC8347) board that works fine with uboot and Linux 2.6.15.<br><br>I am trying to upgrade the kernel so that it runs on the latest release - Linux 2.6.27.<br>So far, I have gotten the kernel to compile on my platform, but of course it does not boot.<br><br>Things have changed drastically since 2.6.15 and the porting methodology used back then is obsolete now. Progress is a good thing :-) I have googled for info on how to accomplish this port but have found nothing so far. In particular, the fact that I am using uboot instead of open firmware makes the task a bit more daunting.<br><br>The file Documentation/powerpc/booting-without-of.txt gives some info on the flattened device tree and and at the end of the "board support" section it states "I will
 describe later the boot process and various callbacks that your platform should implement." but that description is not&nbsp; part of the document.<br><br>I am wondering where I can find more info that will help me accomplish this port.<br><br>thanks a lot for your help.<br>L.K<br><br><br></div></div><br>

      </body></html>
--0-1932266656-1219274686=:49343--
