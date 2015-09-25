Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD7981A0014
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 11:01:05 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 62121140785
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2015 11:01:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 25 Sep 2015 11:01:04 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B76AA3578053
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2015 11:01:00 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8P10qPm61603934
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2015 11:01:00 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8P10Rvg008297
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2015 11:00:28 +1000
Date: Fri, 25 Sep 2015 10:59:29 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, anton@samba.org
Subject: Re: [PATCH 1/1] powerpc: Individual System V IPC system calls
Message-ID: <20150925005929.GA5093@tungsten.ozlabs.ibm.com>
References: <fc46555d58def0d9ad51ba3e6bc66d5dcf537d48.1443073157.git.sam.bobroff@au1.ibm.com>
 <1443141217.2157.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443141217.2157.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 25, 2015 at 10:33:37AM +1000, Michael Ellerman wrote:
> On Thu, 2015-09-24 at 15:39 +1000, Sam Bobroff wrote:
> > This patch provides individual system call numbers for the following
> > System V IPC system calls, on PowerPC, so that they do not need to be
> > multiplexed:
> > * semop, semget, semctl, semtimedop
> > * msgsnd, msgrcv, msgget, msgctl
> > * shmat, shmdt, shmget, shmctl
> 
> Thanks.
> 
> Can you please rebase this on top of linux-next, where we have two new
> syscalls wired up. It should be trivial, just the numbering changes, but I
> think you have a modified libc to actually test the result.

No problem, and yes I can test the glibc changes :-)

Cheers,
Sam.
