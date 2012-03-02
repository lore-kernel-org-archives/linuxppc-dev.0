Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9C24D1007D6
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2012 20:36:18 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Fri, 2 Mar 2012 09:32:10 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q229UW9g2670788
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2012 20:30:34 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q229a4Ah003626
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2012 20:36:04 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 q229a45d003621
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2012 20:36:04 +1100
Received: from grosgo.ozlabs.ibm.com (haven.au.ibm.com [9.190.164.82])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 3E42173A09
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2012 20:36:04 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/12] powerpc: Low level spring cleaning
Date: Fri,  2 Mar 2012 20:35:10 +1100
Message-Id: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series goes through various bits and pieces of our exception
and interrupts handling, fixin bugs, cleaning up code, adding
missing functionality, etc... The last patch of the series is
a reworked variant of my lazy irq rework.

This needs a good review as it touches pretty nasty bits of code
and more testing obviously.
