Return-Path: <vijamann@in.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE53ADDF05
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 01:35:57 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l39FbpBa7831602
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 01:37:51 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0208e0.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l39Fc6VV154926
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 01:38:06 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l39FYZEp014931
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 01:34:35 +1000
Received: from d23m0061.in.ibm.com (d23m0061.in.ibm.com [9.126.109.99])
	by d23av03.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l39FYY67014878
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 01:34:34 +1000
Subject: Memory allocation problem in a module  with fedora core 6 on ppc
To: linuxppc-dev@ozlabs.org
Message-ID: <OF46C39FA8.C2E4F007-ON652572B8.0054EC33-652572B8.00557FBD@in.ibm.com>
From: Vijay Mann <vijamann@in.ibm.com>
Date: Mon, 9 Apr 2007 21:13:44 +0530
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm running fedora core 6 (2.6.17.7)  ppc64 and I'm trying out a module
that works perfectly OK on the same kernel version on intel.
Here's the module:
http://www.captain.at/howto-linux-device-driver-mmap.php

It fails in skeleton_init_module itself in while allocating memory (if i
comment out the memory allocation and corresponding deallocation, insmod
works ok). It throws up a message during insmod:
unable to handle paging request  at addresss xxxxxxxx
and the machine is no longer usable and I've to do a hard reboot.

I'm trying it out on a Power 5  server with nearly I GB RAM and a single
            1.5 GHz processor with SMT enabled.

Am i missing something obvious here?

Thanks in advance for any help,

Vijay
