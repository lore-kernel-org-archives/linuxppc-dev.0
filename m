Return-Path: <ahuja@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E47FDDF23
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 09:42:19 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2LMgCGn005978
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 18:42:12 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2LMgC98310218
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 18:42:12 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2LMgCWf026866
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 18:42:12 -0400
Message-ID: <47E439C3.6050904@austin.ibm.com>
Date: Fri, 21 Mar 2008 17:42:11 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: ppc <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>,
	michael@ellerman.id.au, Linas Vepstas <linasvepstas@gmail.com>
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
documentation explaining what this is. 

A list of open issues / todo list is included in the documentation.
It also appears that the not-yet-released firmware versions this was tested 
on are still,incomplete; this work is also pending.

The following is a list of changes from previous version:
- Deleted ifdef CONFIG_PHYP_DUMP from early_init_dt_scan_phyp_dump function.
- Changed reserve_crashed_mem() to phyp_dump_reserve_mem() as suggested.
- Added #ifdef CONFIG_PHYP_DUMP around of_scan_flat_dt call, removed empty function
  from header file.
- Changed phyp_dump_global to phyp_dump_vars.
- Changed style issues at several places.

Manish & Linas.
