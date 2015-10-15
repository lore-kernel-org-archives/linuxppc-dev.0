Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA58A1A067C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 22:10:52 +1100 (AEDT)
In-Reply-To: <a3cfb270cd61cc3aacdf929e7739ae46dcff86bd.1444700960.git.sam.bobroff@au1.ibm.com>
To: Sam bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, anton@samba.org
Subject: Re: [v2,1/1] powerpc: Individual System V IPC system calls
Message-Id: <20151015111052.C0C3D1402BC@ozlabs.org>
Date: Thu, 15 Oct 2015 22:10:52 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-13-10 at 01:49:28 UTC, Sam bobroff wrote:
> This patch provides individual system call numbers for the following
> System V IPC system calls, on PowerPC, so that they do not need to be
> multiplexed:
> * semop, semget, semctl, semtimedop
> * msgsnd, msgrcv, msgget, msgctl
> * shmat, shmdt, shmget, shmctl
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a34236155afb1cc41945e583

cheers
