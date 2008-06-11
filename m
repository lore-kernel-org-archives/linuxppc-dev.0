Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 547DADDEFE
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 21:49:36 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5BBnW3w025638
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 07:49:32 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5BBnWh4174972
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 05:49:32 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5BBnV69017851
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 05:49:31 -0600
Date: Wed, 11 Jun 2008 07:48:59 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull 'for-2.6.26' branch of 4xx tree
Message-ID: <20080611074859.10fff0a0@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
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

to get one commit from Grant that fixes simpleImage targets.  It seems
both of us missed this when Grant sent it out a while ago.

The tree is based off of Linus' current tree as of this morning.

josh

Grant Likely (1):
      [POWERPC] bootwrapper: add simpleImage* to list of boot targets

 arch/powerpc/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
