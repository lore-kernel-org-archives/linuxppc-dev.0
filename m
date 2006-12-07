Return-Path: <krafft@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 366D467D2E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 03:26:51 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id kB7GQfHM093294
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 16:26:41 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kB7GQfdb2789498
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 16:26:41 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kB7GQeMI026553
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 16:26:41 GMT
Date: Thu, 7 Dec 2006 17:22:59 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: openipmi-developer@lists.sourceforge.net
Subject: [patch 0/1] ipmi: add autosensing of ipmi device on powerpc using
	device-tree
Message-ID: <20061207172259.64168f8c@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, krafft@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi openipmi-developers,

the patch I'll send, adds of_device support to the ipmi_si module.
Having the correct device-tree entries, the ipmi module can be loaded witho=
ut
specifying the resources as module parameters.

If it's looking okay, it would be nice, if you can merge this one.

--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist
