Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A0439DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 03:13:33 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4NHDTY1028911
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:13:29 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4NHDTf0556354
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:13:29 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4NHDT0n031497
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:13:29 -0400
Date: Wed, 23 May 2007 12:13:28 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/4] powerpc: EEH blinkenlights, copyright cleanup
Message-ID: <20070523171328.GY5921@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Paul,

A series of fun but low-priority patches to add per-device EEH
statistics to sysfs. Also, a copyright cleanup.

One RFC: summary EEH info is currently in /proc/ppc64/eeh.
I could prepare a patch to move this to somewhere in the 
sysfs tree ... but I couldn't see the point. Is it worth
the effort? Do you (or anyone else) care?

--linas
