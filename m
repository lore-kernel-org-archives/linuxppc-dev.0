Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2978B7016
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 23:25:26 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <bounces@nabble.com>) id 1Pzpn0-0006Gl-PH
	for linuxppc-dev@ozlabs.org; Wed, 16 Mar 2011 05:25:22 -0700
Message-ID: <31162962.post@talk.nabble.com>
Date: Wed, 16 Mar 2011 05:25:22 -0700 (PDT)
From: Vasanth Ragavendran <ragavendrapec@yahoo.co.in>
To: linuxppc-dev@ozlabs.org
Subject: Powerpc gcc error for mpc8315erdb board
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi

I am facing a problem with my powerpc gcc. Actually i am using a ltib to
configure the kernel and the file system for my mpc8315erdb board from linux
2.6 host machine. and the installation of kernel and filesystem is
successful. i don't have "make" installed in the board and i wanted to
compile cgic library  (an ANSI C library for cgi) for the board, hence i
compiled it on the linux host machine itself but instead of using gcc i used
powerpc-e300c3-linux-gnu-gcc which corresponds to the gcc of the mpc8315erdb
board. however i get an error saying 

powerpc-e300c3-linux-gnu-gcc: error trying to exec 'cc1': execvp: No such
file or directory

however powerpc-e300c3-linux-gnu-gcc is present in /usr/local/bin on the
linux host machine and this directory is part of the path. so powerpc does
exist on the host machine. 

if the error comes on the host linux then i would look for
/usr/libexec/gcc/i486-slackware-linux/4.2.4/ but how do i rectify in this
scenario. the makefile for the cgic was modified according to the powerpc
architecture and i am attaching here. Kindly help! plz!
http://old.nabble.com/file/p31162962/Makefile Makefile 
-- 
View this message in context: http://old.nabble.com/Powerpc-gcc-error-for-mpc8315erdb-board-tp31162962p31162962.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
