In-Reply-To: <20040601211846.GB17412@gate.ebshome.net>
Subject: Re: no core dump from the kernel on SIGSEGV
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OF096B1DBE.952B9CCB-ON85256EA6.0076D881-85256EA6.00771DCE@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Tue, 1 Jun 2004 17:41:04 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >
> > I'm looking at making the kernel core dump on a process that seg
vaulted.
> > What I did was recompiled the kernel specifying a non-zero core file
size
> > rlim[RLIMIT_CORE] = { RLIM_INFINITY, RLIM_INFINITY }.  I was still not
> > getting a core dump.
> >
>
> DO NOT TOUCH the kernel!
>
> Please, read about ulimit shell command.

Okay, you point taken.  I assume ulimit will have the same effect of
assigning it a non-zero value.
What is troubling me is why it doesn't go to the core_dump function in
fs/binfmt_elf.c

David


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
