Message-Id: <200201312049.PAA31178@missioncriticallinux.com>
To: linuxppc-dev@lists.linuxppc.org
From: mod+linuxppc-dev@MissionCriticalLinux.com
Subject: Re: why is tty->pgrp set to -1 for console? 
In-Reply-To: Your message of "Thu, 31 Jan 2002 13:14:54 CST."
             <OFA93F332E.5BEC00AC-ON86256B52.00699C5C-@86256B52.0069BC41LocalDomain>
Date: Thu, 31 Jan 2002 15:49:41 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> We had a problem that ctrl-c was not working on the console.
>
>You need to be running something like mingetty on the console to
>have signals (like ctrl-c) picked up.  If you start Linux with
>something like "init=/bin/bash" then job control signals (like
>control C and control Z) won't work.


That doesn't sound correct.  When the system is in
single-user mode the console shell is a direct child
of init and is spawned without any kind of getty, yet
(at least in my case) the behavior of the shell is
indistinguishable from one spawned from mutiuser mode -
all signals (and job control, etc) are handled correctly.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
