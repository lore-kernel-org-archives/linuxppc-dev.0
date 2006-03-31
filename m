Return-Path: <moilanen@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CEA2B679E0
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 09:09:02 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2VM8xd9000791
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 17:08:59 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2VMC806191636
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 15:12:08 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2VM8xP0028604
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 15:08:59 -0700
Date: Fri, 31 Mar 2006 16:02:03 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] Base pSeries PCIe support
Message-Id: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here are the two base patches for PCIe on pSeries for 2.6.17.

This is enough to probe, find, configure, and run basic I/O to PCIe
enabled devices.

The patches do not include PCIe hotplug, nor multiple MSI vectors per
adapter.

These patches have had limited testing, as firmware still is working on
a few MSI bugs of their own.
