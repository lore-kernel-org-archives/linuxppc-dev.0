Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 84A85DDE05
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 04:32:50 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6HIWlXm019877
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 14:32:47 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6HIWjLf209026
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:45 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6HIWibi013265
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:44 -0600
Received: from [9.10.86.36] (weaponx.rchland.ibm.com [9.10.86.36])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6HIWhB2013222
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:43 -0600
Message-Id: <20070717181547.310201000@linux.vnet.ibm.com>>
Date: Tue, 17 Jul 2007 13:15:47 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 00/14] Current 4xx patch series
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For those interested, here's my current 4xx patch series.  There are a few
cleanups as a pre-requisite for 40x support, some minimal Walnut support, and
another round of Bamboo patches.  These are all based off of Paul's current
tree.

Patches 1 through 7 are likely ready to be merged if there are no large
objections.  The Walnut stuff likely needs another round or two.  The Bamboo
patches can likely go in, but there is no rush there.

Ethernet for 4xx in general is still provided by the out-of-tree emac rewrite
that Ben and David have poked at.  If it doesn't get merged soon, I'll take
a look at getting it working again.

As an aside, I'll likely be setting up a git tree for 4xx soon.  Hopefully
that will help with some of the larger-ish patches.

josh
-- 
