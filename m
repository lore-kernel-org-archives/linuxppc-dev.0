From: Jesper Skov <jskov@redhat.com>
Message-ID: <14480.8703.852087.45813@thinktwice.zoftcorp.dk>
Date: Thu, 27 Jan 2000 11:46:23 +0100 (CET)
To: dony <dony.he@huawei.com.cn>
Cc: Jesper Skov <jskov@cygnus.co.uk>,
        Brendan John Simon <brendan@dgs.monash.edu.au>,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to gdbserver...
In-Reply-To: <388FB1FD.A75F048A@huawei.com.cn>
References: <3889220B.2BD1CB63@huawei.com.cn>
	<otu2k6tn9h.fsf@thinktwice.zoftcorp.dk>
	<388FB1FD.A75F048A@huawei.com.cn>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "dony" == dony  <dony.he@huawei.com.cn> writes:

dony> Has the host and the target been connected via network yet?  If

They have,

dony> so, I type "run" after (gdb) at host side, then (gdb)run The
dony> program being debugged has been started already Start it from
dony> the begging?(y or n) y Starting program: /mytest/mytest Don't
dony> know how to run. Try "help target".

You need to use 'continue'.

dony> I don't know why the program is running at this time.  type
dony> "list" can show my source code.  type "b main" can set
dony> breakpoint .  (gdb) b main Breakpoint 1 at 0x10000328:file
dony> mytest.c, line 4.  (gdb) s Cannot find bounds of current
dony> function

dony> I don't know why I cannot run the program at host side. Am I
dony> missing something?  I am pretty new with "GDB" debug.  Can some
dony> gurus give me some advices?  Thanks very much.


info gdb
man gdb

Jesper

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
