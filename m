Return-Path: <rlary@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1933E1007E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Apr 2011 05:59:40 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3MJqZH3023862
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2011 13:52:35 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3MJxRI9074526
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2011 13:59:27 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p3MJxRtO007325
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2011 13:59:27 -0600
Message-ID: <4DB1DE1A.2080307@linux.vnet.ibm.com>
Date: Fri, 22 Apr 2011 12:59:22 -0700
From: Richard A Lary <rlary@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] powerpc/eeh: Bug fix and enhancement
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: antonb@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set contains three patches, all to eeh.c,
which fix a issue seen on PCIe adapters with devices below
PCIe bridge/switch, gracefully handle case where driver
sets 'needs_freset' for non-PCIe adapter, and display
location information for both PCIe bus and device for
the device which detected an error.

Patches were tested on P5/P6/P7 platforms on a variety
of PCI, PCI-X and PCI-E adapters with no regressions.
