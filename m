Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 49A72DE625
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 05:54:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 82xx performance
Date: Thu, 17 Jul 2008 14:54:55 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04B34E18@ismail.innsys.innovsys.com>
In-Reply-To: <200807172143.57576.arnd@arndb.de>
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807171747.28624.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04B34D32@ismail.innsys.innovsys.com>
	<200807172143.57576.arnd@arndb.de>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
	<linuxppc-dev@ozlabs.org>
Cc: Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> So again, nothing conclusive. I'm running out of ideas.

Is the syscall path different or the same on ppc and powerpc?
Any differences in the task switching, irq handling or page fault
handling?
