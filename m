Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 58D14679A6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 01:33:09 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 26 May 2005 10:33:07 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8593A1@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: Cross compiler
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Anybody know how to set up a cross compiler for nptl support?

I'm trying to use crosstools to compile a gcc-3.4.3/glibc-2.3.4 for
ppc-604 (actually for mpc826x) on i686.

It works if I make it with linuxthreads.
If I do GLIBC_ADDON_OPTIONS=3D=3Dnptl ./my-ppc604_new.sh
Then glibc configure fails with an error about needing a gcc with forced
unwind support.

If I try to set up gcc options to enable threading, then GCC core
compile fails with error that it cannot find pthread.h

Anybody know of a solution?

Rune Torgersen
System Developer
Innovative Systems LLC
1000 Innovative Drive
Mitchell, SD 57301
Ph: 605-995-6120
www.innovsys.com
