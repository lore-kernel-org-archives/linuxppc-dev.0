Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 9D1E267B71
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 06:34:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Allocalting > 4M
Date: Wed, 27 Sep 2006 15:34:00 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189DF9C@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We have an embedded board with 1G of memory.

Is there any way, short of using mem=3D on kernel command line and
reserving memory, to allocate more than 4M of contigous physical memory?
We're trying to allocalte a 8M buffer for use in some DMA transfers for
a bank of DSP's.
We were using get_Free_pages to allocate the meory before we made the
buffer bigger. It seems that get_free_pages cannot allocate more than
2^10 pages (4M on ppc)
I also tried alloc_bootmem, but it fails also.
