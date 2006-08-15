Return-Path: <Clive.Jenkins@xerox.com>
Received: from wbmler3.mail.xerox.com (wbmler3.mail.xerox.com [13.13.138.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wbmler3.mail.xerox.com",
	Issuer "wbmler3.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F11DF67B6B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 22:20:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: edlk4.0 ppc_85xx gdb problems
Date: Tue, 15 Aug 2006 12:46:05 +0100
Message-ID: <35786B99AB3FDC45A821572461791973AC87D4@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <20060815110933.135.qmail@web25911.mail.ukl.yahoo.com>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "emre kara" <emrekara2002@yahoo.co.uk>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> ppc_85xx-gdb vmlinux
> ......
> ......
> (gdb) target remote 192.168.101.101:2001
> Remote debugging using 192.168.101.101:2001
> 0x00000000 in ?? ()
> (gdb) q

When I had this problem (actually using KGDB not BDI2000),
I found that GDB defaulted to e500 architecture (=3Dprocessor)
but it only worked with the less processor-specific
"common" architecture setting:

(gdb) show architecture
The target architecture is set automatically (currently=20
powerpc:e500)
(gdb) set architecture powerpc:common


See also:
http://www.ultsol.com/faq_p311.htm

Regards,
Clive
