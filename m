Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2FCADDDED
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 05:41:53 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1JHkXl-00010I-DV
	for linuxppc-dev@ozlabs.org; Wed, 23 Jan 2008 12:41:50 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4 v4] Add StorCenter port
Date: Wed, 23 Jan 2008 12:41:49 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JHkXl-00010I-DV@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar,

Here is the StorCenter port with the MTD partitions
re-written to be hard-coded PHYSMAP partitions for now.

Addressed list and private commentary as well.

Janitorial Karma has now caussed it to be 4 patches
instead of the original 3.

Please pick up for 2.6.25!

Thanks,
jdl
