Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4A2EDDE38
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 04:02:25 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IITNu-0001KT-KJ
	for linuxppc-embedded@ozlabs.org; Tue, 07 Aug 2007 11:02:22 -0700
Message-ID: <12039337.post@talk.nabble.com>
Date: Tue, 7 Aug 2007 11:02:22 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Telnet on ML410
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi

Im trying to get telnetd from busybox to work on my ML410.  Im running the
telnetd in the init.d but when I connect to the ML410 with telnet I just get
a blank screen without any prompt or login.  Any thoughts.  Here is my
inittab file if that will help, I think it has to do with how my console is
setup since Im using the uartlite.  Im new to this so any help would be
great.
::sysinit:/etc/init.d/rcS

# TERMINALS
#::askfirst:/bin/login
::askfirst:/sbin/getty -L 9600 ttyUL0

# What to do at the "Three Finger Salute"
# NOTE: This will not work over a serial port!
:12345:ctrlaltdel:/sbin/reboot

# What to do at shutdown/reboot
:6:shutdown:/bin/umount -a -r
:6:shutdown:/sbin/swapoff -a

# Stuff to do when restarting the init process
::restart:/sbin/init
-- 
View this message in context: http://www.nabble.com/Telnet-on-ML410-tf4231739.html#a12039337
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
