Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 83D82DE590
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 08:20:35 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2QLKUhR019633
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 17:20:30 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2QLKU0b186758
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 15:20:30 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2QLKUJE030334
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 15:20:30 -0600
Message-ID: <47EABE2D.7080400@linux.vnet.ibm.com>
Date: Wed, 26 Mar 2008 16:20:45 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 0/4] 16G huge page support for powerpc
Content-Type: text/plain; charset=ISO-8859-1
Cc: Adam Litke <agl@linux.vnet.ibm.com>, Andi Kleen <andi@firstfloor.org>,
	Paul Mackerras <paulus@samba.org>
Reply-To: kniht@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch set builds on Andi Kleen's patches for GB pages for hugetlb
posted on March 16th.  This set adds support for 16G huge pages on
ppc64.  Supporting multiple huge page sizes on ppc64 as defined in
Andi's patches is not a part of this set; that will be included in a
future patch.

The first patch here adds an arch callback since the 16G pages are not
allocated from bootmem.  The 16G pages have to be reserved prior to
boot-time.  The location of these pages are indicated in the device tree.

Support for 16G pages requires a POWER5+ or later machine and a little
bit of memory.

Jon
