In-Reply-To: <OF096B1DBE.952B9CCB-ON85256EA6.0076D881-85256EA6.00771DCE@LocalDomain>
Subject: Re: no core dump from the kernel on SIGSEGV
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OF5933DCC7.849C7429-ON85256EA6.00780B05-85256EA6.007990BB@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Tue, 1 Jun 2004 18:07:49 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > >
> > > I'm looking at making the kernel core dump on a process that seg
vaulted.
> > > What I did was recompiled the kernel specifying a non-zero core file
size
> > > rlim[RLIMIT_CORE] = { RLIM_INFINITY, RLIM_INFINITY }.  I was still
not
> > > getting a core dump.
> >
> > Please, read about ulimit shell command.

> Okay, your point taken.  I assume ulimit will have the same effect of
> assigning it a non-zero value.
> What is troubling me is why it doesn't go to the core_dump function
> in fs/binfmt_elf.c

Oh, it's working all along.  One person on our team claims it was a problem
in the kernel.  But I proved it otherwise.

Thanks, David


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
