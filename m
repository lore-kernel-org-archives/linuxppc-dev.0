Date: Fri, 12 Mar 1999 02:15:01 -1000 (HST)
From: Dean Takemori <dean@uhheph.phys.hawaii.edu>
Message-Id: <199903121215.CAA20597@uhhepm.phys.hawaii.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Expect
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been having problems with the expect package, which is part
of the tcltk distribution.  The problem is essentially the TIOCSCTTY
error as reported below from the Expect FAQ.  [Note, not all expect
scripts have this problem, just the ones that allocate ptys.
Unfortunately, this means most (all?) dejanew tests fail.]

I am working with a R4 system, upgraded to egcs-1.1.1-1c,
binutils-2.9.1-19b and glibc-0.961212-1o.

The rest of the tcltk package (tcl-8.0.3-20b, tk-8.0.3-20b,
tix-4.1.0.6-20b and tclx-8.0.3-20b) all compile and install
and test ok.  Expect 5.25, 5.26 and 5.28 all fail.

The FAQ entries quoted below suggest that maybe this is the old
glibc 1.99 != 2 problem in another form

Anyone have any ideas?

>From the Expect 5.28 FAQ:
>#52. Why does Expect fail on RedHat 5.0?
>
>Lots of people have reported the following error from Expect on
>RedHat 5.0:
>
>failed to get controlling terminal using TIOCSCTTY
>parent sync byte write: broken pipe
> 
>Martin Bly <ussc@star.rl.ac.uk> reports that:
> 
>The fault is/was in the GNU libc (aka glibc) provided by Red Hat
>Software.  Our sysadmin updated the version of the C libraries we have
>installed and both problems have vanished - in the case of the expect
>test, without a rebuild.
>======================================================================
> 
>#53. Why does Expect fail on RedHat 5.1?
> 
>People have reported the following error from Expect on RedHat
>5.1:
> 
>failed to get controlling terminal using TIOCSCTTY
>parent sync byte write: broken pipe
> 
>If there are any people
>who have some debugging experience and can reproduce that error on
>RedHat 5.1, read on:
> 
>First look in the man page (or perhaps diff the 5.1 and pre-5.1 man
>pages) governing TIOCSTTY and let me know what you find.
>Alternatively look at the source to xterm (or some other program that
>must allocate a pty) and see how it is allocating a pty.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
