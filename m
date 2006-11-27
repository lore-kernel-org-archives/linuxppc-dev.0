Return-Path: <johnrose@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8E83867CB7
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 08:54:32 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kARLsNYW011889
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 16:54:23 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kARLsMx8507414
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 14:54:22 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kARLsMqn026430
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 14:54:22 -0700
Received: from [9.53.40.59] (sinatra.austin.ibm.com [9.53.40.59])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	kARLsMZ2026418
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 14:54:22 -0700
Subject: powerpc: discontiguous RMO
From: John Rose <johnrose@austin.ibm.com>
To: External List <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1164664463.11970.40.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Mon, 27 Nov 2006 15:54:23 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Suppose that the hypervisor presented a logically contiguous RMO region
to a partition that did not necessarily correspond to a physically
contiguous region.  Would Linux care about this?

Thanks-
John
