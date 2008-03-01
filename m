Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E7A64DDE26
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Mar 2008 03:08:23 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m21G8Kl9029328
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 11:08:20 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m21G8KPH341200
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 11:08:20 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m21G8Kl5020628
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 11:08:20 -0500
Date: Sat, 1 Mar 2008 10:06:13 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: 'next' branch of powerpc4xx tree
Message-ID: <20080301100613.5de31a42@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since all the cool kids are doing it, I went and created a 'next' branch
in the powerpc4xx tree.

I'm basically using it as a place for me to queue things up as they are
submitted that look pretty good for going into the next release.  While
I'll try hard not to rebase it, I can't guarantee that.  Pull requests
to Paul will still come from a 'for-2.6.xx' branch when I think it's
time to send stuff upstream, so if you're looking for something stable
track that instead.

Stephen, if you'd like to add this to your -next tree feel free.
Hopefully it will usually be empty as I merge things into Paul's tree.

As of right now, I have the following patches in the 'next' branch:

David Gibson (1):
      [POWERPC] Start removing linux,network-index in favour of aliases

Stefan Roese (5):
      [POWERPC] 4xx: Add AMCC 460EX/460GT support to cputable.c & cpu_setup_44x.
      [POWERPC] 4xx: Add AMCC Canyonlands 460EX eval board support to platforms/
      [POWERPC] 4xx: Add Canyonlands DTS
      [POWERPC] 4xx: Add 460EX PCIe support to 4xx pci driver
      [POWERPC] 4xx: Add Canyonlands defconfig file

Soon to go in will be the Yosemite board port I did, and moving the
reset function to a common place for 4xx boards.

josh
