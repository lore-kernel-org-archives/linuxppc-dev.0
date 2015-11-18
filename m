Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDA7A1A0957
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 05:55:25 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Wed, 18 Nov 2015 13:55:21 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 73248C9003C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 13:43:29 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAIItJrP60883148
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 18:55:19 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAIItIsJ002253
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 13:55:18 -0500
Received: from oc5780617838.ibm.com ([9.80.96.161])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 tAIItHMq002207
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 13:55:17 -0500
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Add xmon command to dump process/task similar to ps(1)
Date: Wed, 18 Nov 2015 12:55:14 -0600
Message-Id: <1447872915-23552-1-git-send-email-dougmill@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Request for comments

Add a command to xmon that prints basic task information like
ps(1) but includes the kernel stack pointer for use with 't'
(traceback) command.

Adds a macro to be used to wrap memory access with setjmp code
to protect against memory faults.

Is additional locking required? Any other concerns?

Thanks,
Doug
