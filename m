Return-Path: <ppclinux@sundmangroup.com>
Received: from post.uniweb.no (post.uniweb.no [195.159.128.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "post.uniweb.no", Issuer "post.uniweb.no" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1B64E2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Dec 2004 07:31:35 +1100 (EST)
Message-ID: <62302.213.114.195.235.1103055907.squirrel@webmail1.unisite.se>
Date: Tue, 14 Dec 2004 21:25:07 +0100 (CET)
From: ppclinux@sundmangroup.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: MEMORY PROBLEM
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
I have a Freescale-PPC8270 ( Former Motorola ) based board with 256Megs of
RAM.

I am using the Montavista Vista Kernel 2.4.20.

When the system is handling larger files ~100M when NFS mounted and ~20M
when RAMDISKed the kernel crashes since things are being overwritten in
memory.

The crash happens when handling/creating large files by measn of e.g.
* dd
* gunzip
* sftp download
etc. it seems to be a general memory handling problem.

When looking at the memory though there are plenty of free space, or there
should be plenty of free space but for some reason things are
overwritten...

The Kernel reports actually 256M of memory. Top also shows that there is o
r should be more than enough free memory for the operations I am trying to
pull :-))

Can you give me suggestions where to start digging into this problem?

Best Regards // Matias
