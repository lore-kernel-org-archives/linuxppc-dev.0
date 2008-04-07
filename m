Return-Path: <hollisb@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6AAD8DE102
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 06:53:50 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m37KrlPK005667
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 16:53:47 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m37Krl1j249392
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 16:53:47 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m37KrlAI005472
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 16:53:47 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 0 of 3] KVM for PowerPC 440
Message-Id: <patchbomb.1207601611@localhost.localdomain>
Date: Mon, 07 Apr 2008 15:53:31 -0500
From: Hollis Blanchard <hollisb@us.ibm.com>
To: linuxppc-dev@ozlabs.org, kvm-devel@lists.sourceforge.net
Cc: kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Implement initial support for KVM for PowerPC 440. There are just two small
prerequisite patches, and then the bulk of the code can't be split easily.

Please review; I would like to submit these for 2.6.26. There is plenty of work
to do, both functional and optimization, but this code is sufficient to run
unmodified 440 Linux guests on a 440 Linux host. What's your favorite bike shed
color?

(Note for current users: since KVM_EXIT_DCR changed, you must rebuild your
userspace to match this kernel.)
