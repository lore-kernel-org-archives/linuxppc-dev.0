Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BAA22DEA0D
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 00:26:04 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4KEQ1iX022872
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 10:26:01 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4KEQ1fA086580
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 08:26:01 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4KEQ1Mo022126
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 08:26:01 -0600
Received: from zod.rchland.ibm.com (wecm-9-67-211-47.wecm.ibm.com
	[9.67.211.47])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m4KEQ0GA022044
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 08:26:00 -0600
Date: Tue, 20 May 2008 09:21:43 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to 4xx next branch
Message-ID: <20080520092143.788b46e3@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

The following patches have been added to the next branch of the 4xx
tree.  I plan on letting them sit in there for a few days and then
asking Paul to pull into his tree.  That way if I've screwed something
up only poor Stephen will get hit by it and I can fix things without
causing major problems for others.

I have a few more patches to add, but nothing really major.  If the
outstanding questions on sam440ep are answered/fixed then that will
likely go in too.  If there are things I've missed, please let me know.

josh

David Gibson (1):
      [POWERPC] Convert remaining dts-v0 files to v1

Josh Boyer (2):
      [POWERPC] 4xx: Fix PCI mem in rainier DTS
      [POWERPC] 4xx: Fix compiler warning on DCR_NATIVE only builds

Sean MacLennan (2):
      [POWERPC] PIKA Warp: Update DTS to support Rev B boards
      [POWERPC] PIKA Warp: Update platform code to support Rev B boards

Stephen Neuendorffer (1):
      [POWERPC] Refactor DCR code
