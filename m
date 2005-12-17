Return-Path: <maboutte@pacbell.net>
Received: from smtp113.sbc.mail.mud.yahoo.com (smtp113.sbc.mail.mud.yahoo.com
	[68.142.198.212]) by ozlabs.org (Postfix) with SMTP id 74AA36889F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Dec 2005 19:23:07 +1100 (EST)
Message-ID: <43A3C9B2.6040401@pacbell.net>
Date: Sat, 17 Dec 2005 00:17:54 -0800
From: Michael Boutte <maboutte@pacbell.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Building a Root Filesystem
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
I seem to be stuck at one point in my first embedded Linux project. I 
built a custom MPC875 board and have figured out how to get U-Boot to 
compile and run. Then I learned to compile an initial Linux 2.4.25 using 
the ELDK with a basic root filesystem via the "SELF" included in the 
ELDK (thank you WD and others). Now I want to build a new root 
filesystem with the modules included. So then I have used the "make 
modules" and "make ... modules_install" commands plus used the procedure 
in the DULG section 9.6 to unpack the ramdisk image and mount it in the 
/mnt/tmp/ directory.
That is point where I do not know what to do next. It would seem that I 
need to merge the modules and other items I may want to add (for example 
appWeb) with the simple root filesystem and re-compress it for use just 
like the original ramdisk image. I just do not seem to find any 
information on this process either in the DULG or anywhere else on the web.
Any help would be greatly appreciated.

Mike Boutte
