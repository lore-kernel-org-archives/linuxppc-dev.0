Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B3751A098B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 22:46:26 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Sam bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@ozlabs.org,
 mikey@neuling.org, anton@samba.org
Subject: Re: [v2,1/1] powerpc: Individual System V IPC system calls
Date: Tue, 13 Oct 2015 13:46:11 +0200
Message-ID: <8190190.Oz6apY7Xxc@wuerfel>
In-Reply-To: <20151013093842.B3EA21402D6@ozlabs.org>
References: <20151013093842.B3EA21402D6@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 13 October 2015 20:38:42 Michael Ellerman wrote:
> On Tue, 2015-13-10 at 01:49:28 UTC, Sam bobroff wrote:
> > This patch provides individual system call numbers for the following
> > System V IPC system calls, on PowerPC, so that they do not need to be
> > multiplexed:
> > * semop, semget, semctl, semtimedop
> > * msgsnd, msgrcv, msgget, msgctl
> > * shmat, shmdt, shmget, shmctl
> 
> You tested this right?   Tell me about it.
> 
> Also we could make these available to SPU programs, but I don't think there's
> any point, no one's going to do a libc update for that.
> 

The existing sys_ipc is also in the list of exceptions that are
not exported to the SPU. I don't remember what the reason for this
is, but there probably was one.

	Arnd
