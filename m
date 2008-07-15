Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id E5BCDDE633
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jul 2008 03:24:37 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KIoGP-0000sh-QJ
	for linuxppc-embedded@ozlabs.org; Tue, 15 Jul 2008 10:24:33 -0700
Message-ID: <18470632.post@talk.nabble.com>
Date: Tue, 15 Jul 2008 10:24:33 -0700 (PDT)
From: Alex_SYS <schmid-grafenau@t-online.de>
To: linuxppc-embedded@ozlabs.org
Subject: Videomode 800x480
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello, I have the problem that I need a Framebuffer resolution 800x480!
Since now I have filled the fb_info, var and fix Structs!
But there was the problem with the resolution!
I have found out that the problem is the videomode!
In modedb there is unfortunately no 800x480 Videomode, and I have tried my
own 800x480 Struct, but the Kernel does`t want my settings (I tried to
change an 800x600 to 800x480 only by changing yres to 480).
Can someone tell me please a working fb_videomode struct for 800x480?
The syncs are setted up by U-Boot .

Thank you very much
-- 
View this message in context: http://www.nabble.com/Videomode-800x480-tp18470632p18470632.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
