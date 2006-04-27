Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id EC79A67A04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 05:42:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: FT u-boot shim 
Date: Thu, 27 Apr 2006 14:30:08 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859673@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Wolfgang Denk" <wd@denx.de>
Cc: linuxppc-dev@ozlabs.org, U-Boot Users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Would it be possible to have the kernel smart enough that if it gets
passed a bd_t pointer, it updates the dts before booting fully.=20
Newer u-boot versions that support dts then would pass a NULL bd_t
pointer to a kernel that supports dts. Kernel would then not update the
dts, but use the one it gets handed.

bootm should be able to see if the kernel has an attached dts, update it
with runtime parameters, and hand it off to the kernel. If it is an old
kernel, hand it the bd_t pointer.
