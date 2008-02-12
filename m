Return-Path: <ahuja@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 53F51DDDF5
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 17:31:17 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1C6VCXF020795
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 01:31:12 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1C6VCAU207560
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 23:31:12 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1C6VBXF023208
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 23:31:12 -0700
Message-ID: <47B13D2E.1070001@austin.ibm.com>
Date: Tue, 12 Feb 2008 00:31:10 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/8] pseries: phyp dump: hypervisor-assisted dump
References: <4782B985.2090508@austin.ibm.com>
In-Reply-To: <4782B985.2090508@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
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
documentation explaining what this is :-). Yes, its supposed
to be an improvement over kdump.

A list of open issues / todo list is included in the documentation.
It also appears that the not-yet-released firmware versions this was tested 
on are still, ahem, incomplete; this work is also pending.

I have included most of the changes requested. Although, I did find
one or two, fixed in a later patch file rather than the first location
they appeared at.

Also it now does not block any memory on machines other than power6 boxes
which have the requisite firmware. This is from a power5 box.

from jal-lp6 a power5 machine.
.........
Phyp-dump not supported on this hardware
Using pSeries machine description
console [udbg-1] enabled
.......

Since I changed a few more things, I am reposting all the patches.

-- Manish & Linas.
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
