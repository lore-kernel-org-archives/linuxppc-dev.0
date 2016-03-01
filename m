Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE1961A0BEA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 21:09:45 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F2BC140BA3
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 21:09:45 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 1 Mar 2016 20:09:44 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9C51B357805A
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 21:09:42 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u21A9YOV27721974
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Mar 2016 21:09:42 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u21A99TA014833
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Mar 2016 21:09:10 +1100
Date: Tue, 1 Mar 2016 15:38:46 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: Re: [PATCH v2 5/8] powerpc/ftrace: Use generic
 ftrace_modify_all_code()
Message-ID: <20160301100845.GC13436@linux.vnet.ibm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <1456737989-8755-1-git-send-email-mpe@ellerman.id.au>
 <1456737989-8755-5-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1456737989-8755-5-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2016-02-29 20:26:26]:

> From: Torsten Duwe <duwe@lst.de>
> 
> Convert powerpc's arch_ftrace_update_code() from its own version to use
> the generic default functionality (without stop_machine -- our
> instructions are properly aligned and the replacements atomic).
> 
> With this we gain error checking and the much-needed function_trace_op
> handling.
> 
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
