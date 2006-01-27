Return-Path: <vroopcha@mcw.edu>
Received: from ms-smtp-01.rdc-kc.rr.com (ms-smtp-01.rdc-kc.rr.com
	[24.94.166.115]) by ozlabs.org (Postfix) with ESMTP id D76D668A92
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jan 2006 16:24:35 +1100 (EST)
Date: Thu, 26 Jan 2006 23:24:02 -0600 (CST)
From: vinai <vroopcha@mcw.edu>
To: Debian PowerPC List <debian-powerpc@lists.debian.org>,
	"LinuxPPC Developers' List" <linuxppc-dev@ozlabs.org>
Subject: ivtv 0.4.2 driver works on powerpc !!
Message-ID: <Pine.OSX.4.62.0601262228470.3234@romy.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: ivtv-devel@ivtvdriver.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Folks,

Don't know if this has been made widely known, but I thought I's share
the last couple of days worth of experimenting.

The setup - a PowerMac 8500, running "stock" Debian testing except for
my own kernel compiled from the 2.6.15.1 sources from kernel.org.  The
machine has 1 G RAM, 200 MHz 604e PowerPC CPU and a Firmtek SATA drive
controller running a 36 G 10K WD Raptor drive, and the capture device
under testing is a Hauppage 350 PCI card.

In my kernel .config file, I have video4linux and I2C support enabled,
as per the instructions on the ivtv web site.  I built and used only
hardware modules from the ivtv 0.4.2 sources.  I grabbed the firmware
and installed it, again per instructions.

If I do:

     cat /dev/video0 > test.mpg

after a reboot, the hardware won't respond.  However, if I remove the
ivtv module then do a modprobe of that module again, the above command 
will work.  "modprobe"-ing without "rmmod"-ing did not allow the card
to function.

I was able to capture about 20 s of video, with no noticeable dropped
frames, even on this slow machine.  This machine can't even play the
captured clips, but transfer to another machine gave me a valid and
playable MPEG-2 file.  I plan to do some more testing over the next
few days, and see if I can get this to actually work predictably...

Cheers, and thanks to all whose work and efforts made this happen !!

cheers
vinai
