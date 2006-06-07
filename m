Return-Path: <moilanen@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DDBDE67B7A
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 07:10:33 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k57LAU56024202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 17:10:30 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k57LAUvv291698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 15:10:30 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k57LATGX000596
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 15:10:29 -0600
Date: Wed, 7 Jun 2006 16:02:12 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] PPC64 PCIe support
Message-Id: <20060607160212.1203d9ea.moilanen@austin.ibm.com>
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

Here are the three patches for PCIe/MSI on pSeries for 2.6.18.

Since MSI is a requirement for PCIe, I have put these in one batch.

This is enough to probe, find, configure, and run basic I/O to PCIe
enabled devices.  However, these patches do not include support for
PCIe hotplug, nor multiple MSI vectors.

There is a supplemental patches which will be needed in the
future.  Specifically adding a PCIe bit for
ibm,client-architecture-support.  To my knowledge this bit has not been
defined yet.
