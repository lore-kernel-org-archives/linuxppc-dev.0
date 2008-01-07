Return-Path: <ahuja@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 781D4DDE3F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 10:45:17 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m07NjDTk021519
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 18:45:13 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m07NjDmk450546
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 18:45:13 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m07NjB3l015077
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 18:45:13 -0500
Message-ID: <4782B985.2090508@austin.ibm.com>
Date: Mon, 07 Jan 2008 17:45:09 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/8] pseries: phyp dump: hypervisor-assisted dump
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linasvepstas@gmail.com, lkessler@us.ibm.com,
	strosake@us.ibm.com
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
documentation explaining what this is  :-) . Yes, its supposed
to be an improvement over kdump.

The patches mostly work; a list of open issues / todo list
is included in the documentation.  It also appears that 
the not-yet-released firmware versions this was tested 
on are still, ahem, incomplete; this work is also pending.

-- Linas & Manish
