Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B891DDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 00:52:28 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4JEqO7B002661
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 10:52:24 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4JEqKF3057400
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 10:52:20 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4JEqKXJ008446
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 10:52:20 -0400
Date: Mon, 19 May 2008 09:48:16 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull 'for-2.6.26' branch of 4xx tree
Message-ID: <20080519094816.41ea91d4@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.26

to pick up one bugfix for 4xx.  This patch works around an errata for
440{EP,GR,EPx,GRx} chips that can cause hangs on the PLB4 bus.

The tree is based off of Linus' 2.6.26-rc3.  If you've no objections
or other patches queued up, Linus can pull directly if he'd like.

josh

Josh Boyer (1):
      [POWERPC] 4xx: Workaround for CHIP_11 Errata

 arch/powerpc/boot/4xx.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
