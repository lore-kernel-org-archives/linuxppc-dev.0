Return-Path: <zhonglei@RCS-9000.COM>
Received: from RCS-9000.COM (unknown [218.94.131.104])
	by ozlabs.org (Postfix) with ESMTP id A012E681B0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 17:55:37 +1000 (EST)
Date: Wed, 31 Aug 2005 15:58:31 +0800
Message-Id: <200508311558.AA3342540@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "zhonglei" <zhonglei@RCS-9000.COM>
To: <linuxppc-embedded@ozlabs.org>
Subject: how to link .o
Reply-To: zhonglei@RCS-9000.COM
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi 
  In my module htm.c , I use the a set of API function in bestcomm.o.
I include the bestcomm.h in htm.c and in makefile I write:
ppc_82xx-gcc -c htm.c .
when I insmod htm.o , the "unresolved symbol" error happens because there is no definition of the function.

My question is: 
What command should I write in makefile to link the bestcomm.o into my htm.o to make the function defined?
BestRegards
zhonglei
