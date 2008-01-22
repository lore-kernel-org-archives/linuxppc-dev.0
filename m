Return-Path: <ahuja@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 00012DDE3C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 06:13:42 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0MJDd8E023005
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 14:13:39 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0MJDd9e161504
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 14:13:39 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0MJDc8K025724
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 14:13:39 -0500
Message-ID: <4796401D.5010907@austin.ibm.com>
Date: Tue, 22 Jan 2008 13:12:29 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>,
	linasvepstas@gmail.com, Michael Strosaker <strosake@us.ibm.com>,
	Larry Kessler <lkessler@us.ibm.com>
Subject: [PATCH 0/8] pseries: phyp dump: hypervisor-assisted dump
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series of patches implement a basic framework
for hypervisor-assisted dump. The very first patch provides 
documentation explaining what this is    :-)   . Yes, its supposed
to be an improvement over kdump.

A list of open issues / todo list is included in the documentation.
It also appears that the not-yet-released firmware versions this was tested 
on are still, ahem, incomplete; this work is also pending.

I have included most of the changes requested. Although, I did find
one or two, fixed in a later patch file rather than the first location
they appeared at.

-- Manish & Linas.
