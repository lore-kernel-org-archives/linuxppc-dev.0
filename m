Return-Path: <blueskyjb@verizon.net>
Received: from vms042pub.verizon.net (vms042pub.verizon.net [206.46.252.42])
	by ozlabs.org (Postfix) with ESMTP id 36145DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Feb 2007 07:25:36 +1100 (EST)
Received: from vms061.mailsrvcs.net ([192.168.1.2])
	by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0JDK00052OPZJMI0@vms042.mailsrvcs.net> for
	linuxppc-embedded@ozlabs.org; Fri, 16 Feb 2007 14:25:12 -0600 (CST)
Date: Fri, 16 Feb 2007 14:25:11 -0600 (CST)
From: <blueskyjb@verizon.net>
Subject: What happened to include/asm-ppc??
To: linuxppc-embedded@ozlabs.org
Message-id: <32201137.34111171657512254.JavaMail.root@vms061.mailsrvcs.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I'm using lastest ELDK (4.1) with Linux 2.6.19.2.
After upgrading from ELDK 4.0 I can't get any of
my user apps to build.  The problem is that many
of the headers that were in include/asm-ppc are
now gone.  For example, posix_types.h and sigcontext.h.
All the other arches seem to have a full complement
of header files in their asm directories.  Can someone give me a clue??  Thanks!
