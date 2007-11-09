Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 011E4DDDD5
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 09:02:04 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA9M1xZM009656
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 17:01:59 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lA9M1xXa121604
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 17:01:59 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA9M1xJS002523
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 17:01:59 -0500
Received: from [9.67.175.8] (wecm-9-67-175-8.wecm.ibm.com [9.67.175.8])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	lA9M1wSF002506
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Nov 2007 17:01:59 -0500
Subject: On-going 4xx porting
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 09 Nov 2007 16:01:41 -0600
Message-Id: <1194645701.3207.17.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

For those interested, I have a few things I'd like to focus on for
2.6.25 in regards to the current arch/powerpc 4xx porting effort.  Below
is a brief list of drivers in no particular order:

PCI support
USB (440EP(x), etc)
I2C
GPIO
NDFC
RTC

I'd also like to try and get the larger page size patches ported and
merged.  If another hugetlbfs type patch shows up, that would be good
too.  There is also the HW watchpoint support patch, and of course new
board ports.

At some point we should really be able to have a single vmlinux be
wrapped with different zImage wrappers and .dts files and have it boot
on those various boards just fine.  So I'll be looking at accomplishing
that as well.  That should make new board ports fairly easy to do.

josh
