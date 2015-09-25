Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D97101A0205
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 10:33:37 +1000 (AEST)
Message-ID: <1443141217.2157.1.camel@ellerman.id.au>
Subject: Re: [PATCH 1/1] powerpc: Individual System V IPC system calls
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, anton@samba.org
Date: Fri, 25 Sep 2015 10:33:37 +1000
In-Reply-To: <fc46555d58def0d9ad51ba3e6bc66d5dcf537d48.1443073157.git.sam.bobroff@au1.ibm.com>
References: <fc46555d58def0d9ad51ba3e6bc66d5dcf537d48.1443073157.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-24 at 15:39 +1000, Sam Bobroff wrote:
> This patch provides individual system call numbers for the following
> System V IPC system calls, on PowerPC, so that they do not need to be
> multiplexed:
> * semop, semget, semctl, semtimedop
> * msgsnd, msgrcv, msgget, msgctl
> * shmat, shmdt, shmget, shmctl

Thanks.

Can you please rebase this on top of linux-next, where we have two new
syscalls wired up. It should be trivial, just the numbering changes, but I
think you have a modified libc to actually test the result.

cheers
