Return-Path: <blueskyjb@verizon.net>
Received: from vms040pub.verizon.net (vms040pub.verizon.net [206.46.252.40])
	by ozlabs.org (Postfix) with ESMTP id 724ABDDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Feb 2007 12:44:21 +1100 (EST)
Received: from vms061.mailsrvcs.net ([192.168.1.2])
	by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0JDL00E3U3HB6HC1@vms040.mailsrvcs.net> for
	linuxppc-embedded@ozlabs.org; Fri, 16 Feb 2007 19:43:59 -0600 (CST)
Date: Fri, 16 Feb 2007 19:43:59 -0600 (CST)
From: <blueskyjb@verizon.net>
Subject: Problem building app when ARCH=ppc
To: linuxppc-embedded@ozlabs.org
Message-id: <673046.109041171676639797.JavaMail.root@vms061.mailsrvcs.net>
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

This is a follow-up to my earlier post about
include/asm-ppc.

I've got a simple test case that won't build with
ELDK 4.1 configured for a ppc arch:

#include <signal.h>
main(int argc, char **argv)
{
   printf("hello world\n");
}

This build just fine with ELDK 4.0 using:

% ppc_6xx-gcc hello_world.c

In ELDK 4.1 it gets an error: asm/sigcontext.h: No such file or directory.  

Is include/asm-ppc broken
or do I need to add some additional compile option?

Thanks,

-- Jimmy
