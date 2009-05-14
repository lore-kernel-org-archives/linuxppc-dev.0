Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2DAB8DDFAE
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 23:42:59 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp09.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4EDFik6003891
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 09:15:44 -0400
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4EDgweT438530
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 23:42:58 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4EDgwXa021783
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 23:42:58 +1000
Date: Thu, 14 May 2009 19:12:50 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC Patch 0/6] PPC64: Hardware Breakpoint interfaces - ver II
Message-ID: <20090514134250.GA14229@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alan Stern <stern@rowland.harvard.edu>, Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,
	Please find a revised patchset that implement hardware breakpoint
interfaces for PPC64 architecture. The changes over the previous patchset
posted here: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/071942.html
are given below.

Kindly let me know your comments about the same.

Changelog - ver II
------------------
(Ver I: http://ozlabs.org/pipermail/linuxppc-dev/2009-May/071942.html)

- Split the monolithic patch into six logical patches

- Changed the signature of arch_check_va_in_<user><kernel>space functions. They
  are now marked static.

- HB_NUM is now called as HBP_NUM (to preserve a consistent short-name
  convention)

- Introduced hw_breakpoint_disable() and changes to kexec code to disable
  breakpoints before a reboot.
  
- Minor changes in ptrace code to use macro-defined constants instead of
  numbers.

- Introduced a new constant definition INSTRUCTION_LEN in reg.h

Thanks,
K.Prasad
