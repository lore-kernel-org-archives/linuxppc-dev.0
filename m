Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id BD588DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Aug 2008 16:23:21 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KUy98-0004Zn-EB
	for linuxppc-embedded@ozlabs.org; Sun, 17 Aug 2008 23:23:18 -0700
Message-ID: <19026508.post@talk.nabble.com>
Date: Sun, 17 Aug 2008 23:23:18 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: WARNING: "setup_irq" [/home/misbah/driver_Hwtimer/omap_timer.ko]
	undefined!
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


Hi all,

I am compiling a driver code which is giving the compilation error for
"setup_irq" function not defined. I am including all the header file for for
its declaration. Other inbuilt drivers which are already there with the
kernel source is also giving error if i compile seperatly. 

I have no idea why it is not able to find the setup_irq function where in it
has the extern declaration in the file /linux/irq.h 

Insted if this function if i use request_irq to hook the interrupt it
compiles but it does not gets the interrupt 

can any one suggest me where am i going wrong :(

What could be the possible reason to such problem ...


--- Misbah <><
-- 
View this message in context: http://www.nabble.com/WARNING%3A-%22setup_irq%22---home-misbah-driver_Hwtimer-omap_timer.ko--undefined%21-tp19026508p19026508.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
