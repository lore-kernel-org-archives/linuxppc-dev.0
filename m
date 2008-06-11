Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 108A5DDF11
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 22:36:06 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5BCa2Qf017760
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 08:36:02 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5BCa2Ja165872
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 06:36:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5BCa2tJ013702
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 06:36:02 -0600
Date: Wed, 11 Jun 2008 08:35:29 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to 4xx 'next' branch
Message-ID: <20080611083529.23aa1689@zod.rchland.ibm.com>
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

The following patches have been added to the 'next' branch of the 4xx
tree.  As usual, I will let them sit there for a few days and then ask
Paul to pull.

If I've missed any patches for 2.6.27, now would be the time to point
them out to me.

josh

Giuseppe Coviello (2):
      powerpc/4xx: Sam440ep support
      powerpc/4xx: Convert Sam440ep DTS to dts-v1

Imre Kaloz (1):
      powerpc/4xx: MTD support for the AMCC Taishan Board

Josh Boyer (1):
      Revert "[POWERPC] 4xx: Fix 460GT support to not enable FPU"

Stefan Roese (1):
      powerpc/4xx: PCIe driver now detects if a port is disabled via the dev-tre

Valentine Barshak (1):
      powerpc/4xx: Fix resource issue in warp-nand.c
