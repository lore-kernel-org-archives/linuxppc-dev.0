Message-ID: <3EA667D7.8020201@tataelxsi.co.in>
Date: Wed, 23 Apr 2003 15:45:51 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: some execve related queries....
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
We use linux kernel version 2.4.1 on a custom derivative board of
mpc8260ads.
Kernel is booting up without any problem uptil the init call in
init/main.c In the main.c file, there are four execve calls succeeded by
a panic().

Now thequestions are
1. As far as I know execve is usually called only from userspace. A grep
on System.map gave me an entry for execve. I am a little confused by
this.I know that init is pid 0, which runs as a kernel thread. Is it
possible to call execve from a kernel thread? How does this work?

2. I could not find execve function in the kernel at all. As far as I
know, kernel supplied sys_exec and stdlib converts the arguments of
execve to those of sys_execve.
(In i386, processor registers are used for parameter passing, but in
ppc, i see all parameters are passed as function params).
In kernel, sys_execve is executed, which calls do_execve(). In ppc, out
of 7 parameters only 3 are used. Why to pass other params at all?

Any ideas/ pointers?

Thanks,
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
