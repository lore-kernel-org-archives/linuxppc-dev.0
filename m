Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B6A5DDEF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 06:12:16 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1INwYm-0000qG-Ff
	for linuxppc-embedded@ozlabs.org; Wed, 22 Aug 2007 13:12:12 -0700
Message-ID: <12282029.post@talk.nabble.com>
Date: Wed, 22 Aug 2007 13:12:12 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: gdbserver and c++
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
Im having trouble debugging a C++ app through eclipse using gdbserver
running on my ML410 board.  I could debug a standard C app no problem but
now I get a :
Cannot access memory at address 0x10010008
The program Im trying to debug is just using a couple cin and cout functions
nothing too complicated.  I think I have the shared libraries on Eclipse
pointing to the root file system image on my host computer, i used the
command 
set solib-absolute-prefix /opt/crosstool/ml410_rfs
in a gdb command file that eclipse calls, is there anything else I need to
add to it?
Thanks
Kevin
-- 
View this message in context: http://www.nabble.com/gdbserver-and-c%2B%2B-tf4313806.html#a12282029
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
