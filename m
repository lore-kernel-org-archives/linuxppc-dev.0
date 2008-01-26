Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 30EA9DDE0C
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 00:23:44 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m0QDNEmk011942
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 00:23:14 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0QDRLFU145164
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 00:27:21 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0QDNhdI032460
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 00:23:43 +1100
Message-ID: <479B3453.3030105@linux.vnet.ibm.com>
Date: Sat, 26 Jan 2008 18:53:31 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>,
	Andy Whitcroft <apw@shadowen.org>, Badari Pulavarty <pbadari@us.ibm.com>
Subject: [BUILD FAILURE]2.6.24-git{1,2} kernel powerpc linkage failure
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The 2.6.24-git2 kernel build fails on the power boxes with following build failure

  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/powerpc/kernel/built-in.o: In function `fphalf':
arch/powerpc/kernel/vector.S:(.toc+0x1428): undefined reference to `devices_subsys'
make: *** [.tmp_vmlinux1] Error 1

This built-failure was seen in the mm broken-out-2007-11-06-02-32, I have tested 
the patch posted to lkml at http://lkml.org/lkml/2007/11/6/208 fixes this issue.

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
