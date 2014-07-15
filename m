Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04A531A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 01:06:52 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 15 Jul 2014 20:36:50 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 24A89394004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 20:36:47 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6FF744s61210754
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 20:37:05 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6FF6iYm015678
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 20:36:45 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] powerpc: subpage_protect: Increase the array size to take
 care of 64TB
In-Reply-To: <1405435950-24187-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1405435950-24187-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 15 Jul 2014 20:36:44 +0530
Message-ID: <87zjgaacfv.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> We now support TASK_SIZE of 16TB, hence the array should be 8.

should be                     ^^^ 64TB   

>
> Fixes the below crash:

-aneesh
