Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AEFABDDECB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 04:17:27 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IJCZX-0000iT-66
	for linuxppc-embedded@ozlabs.org; Thu, 09 Aug 2007 11:17:23 -0700
Message-ID: <12077740.post@talk.nabble.com>
Date: Thu, 9 Aug 2007 11:17:23 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: BusyBox Mount
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

I want to mount the first partion of my compact flash in a users home folder
during bootup.  This partion should be owned by the user and be read write
and executable.  I am using the command:
mount -t vfat /dev/xsa1 /home/Dak
in the rcS startup script.  This works fine but it is owned by the root, if
I try to change the ownership with chown as root it says that Operation not
permitted, if I Chmod to 777 it appears to take but when you ls -l it out it
says that it is onlt rw by the owner root.
Any suggestions
khollan
-- 
View this message in context: http://www.nabble.com/BusyBox-Mount-tf4244254.html#a12077740
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
