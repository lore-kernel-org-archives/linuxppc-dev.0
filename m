Return-Path: <ahuja@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4975DDF18
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 05:46:13 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0MIk9HC027640
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 13:46:09 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0MIk7DY045284
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 11:46:08 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0MIk4GP012074
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 11:46:04 -0700
Message-ID: <479639EA.9050409@austin.ibm.com>
Date: Tue, 22 Jan 2008 12:46:02 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>
Subject: [PATCH 0/8] pseries: phyp dump: hypervisor-assisted dump
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linasvepstas@gmail.com, lkessler@us.ibm.com,
	Michael Strosaker <strosake@us.ibm.com>
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
documentation explaining what this is   :-)  . Yes, its supposed
to be an improvement over kdump.

A list of open issues / todo list is included in the documentation.
It also appears that the not-yet-released firmware versions this was tested 
on are still, ahem, incomplete; this work is also pending.

I have included most of the changes requested. Although, I did find
one or two, fixed in a later patch file rather than the first location
they appeared at.

-- Manish & Linas.
