Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FE161A075D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 23:32:12 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Thu, 19 Nov 2015 05:32:10 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 933F66E803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 07:20:17 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAJCW7cJ55312630
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 12:32:07 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAJCU9A1031882
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 07:30:09 -0500
Received: from oc5780617838.ibm.com ([9.80.96.161])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 tAJCU32p031507
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 07:30:04 -0500
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: RESEND: Add xmon command to dump process/task similar to ps(1)
Date: Thu, 19 Nov 2015 06:31:57 -0600
Message-Id: <1447936318-18487-1-git-send-email-dougmill@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Resending with Signed-Off line.

Request for comments

Add a command to xmon that prints basic task information like
ps(1) but includes the kernel stack pointer for use with 't'
(traceback) command.

Adds a macro to be used to wrap memory access with setjmp code
to protect against memory faults.

Is additional locking required? Any other concerns?

Thanks,
Doug
