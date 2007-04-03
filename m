Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DB1FADDE2B
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:26:38 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l330QV9O001603
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:26:31 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l330QV6S310806
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:26:31 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l330QUOY028226
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:26:30 -0400
Date: Mon, 2 Apr 2007 19:26:29 -0500
To: Greg KH <gregkh@suse.de>
Subject: [PATCH 0/19]: RPAPHP pci hotplug cleanup patchbomb
Message-ID: <20070403002629.GI4922@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Greg, 

Please queue these cleanp patches for 2.6.22; cc'ing akpm.

This is a collection of very small patches that clean up various bits and 
pieces of the RPAPHP hotplug code. They eliminate about 100 lines of code, 
almost without changing any function; there are a few minor bugfixes to 
various error paths, and one memleak fix. Some documentation is added.
The result is, I beleive, slightly more readable, easier to understand
code. In particular, the enable/disable add/remove code paths are now
more obviously symmetrical in thier function.

--linas
