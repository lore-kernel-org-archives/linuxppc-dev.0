Return-Path: <gsslist+linuxppc@anthropohedron.net>
Received: from sccrmhc13.comcast.net (sccrmhc13.comcast.net [63.240.76.28])
	by ozlabs.org (Postfix) with ESMTP id 0E20967D69
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Aug 2005 03:58:55 +1000 (EST)
Received: from gss by roadkill with local (Exim 4.52) id 1DzeJD-0008E3-Qa
	for linuxppc-dev@ozlabs.org; Mon, 01 Aug 2005 13:42:39 -0400
Date: Mon, 1 Aug 2005 13:42:39 -0400
From: Gregory Seidman <gsslist+linuxppc@anthropohedron.net>
To: LinuxPPC dev list <linuxppc-dev@ozlabs.org>
Message-ID: <20050801174238.GA31016@anthropohedron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: endianness of Linux kernel RAID
Reply-To: gsslist+linuxppc@anthropohedron.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It turns out that if one uses the kernel (2.4.x-2.6.x) RAID support (RAID5,
anyway, since that's all I've tested), the RAID'd disks cannot be moved to
another system with a different endianness. I don't know how hard that
would be to fix, but it did mean that when my ancient Mac clone I was using
as a server died I couldn't bring the RAID over to my spare x86 Linux box;
I had to dedicate other hardware (my dual G4 that I had been happily using
with OS X) to the task instead.

Unfortunately, I haven't gotten into kernel development and, therefore, do
not have the necessary expertise to fix it. Is anyone here interested in
this issue?

--Greg
