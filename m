To: dony <dony.he@huawei.com.cn>
Cc: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gdbserver
References: <3889220B.2BD1CB63@huawei.com.cn>
From: Jesper Skov <jskov@cygnus.co.uk>
Date: 22 Jan 2000 11:27:06 +0100
In-Reply-To: dony's message of "Sat, 22 Jan 2000 11:20:43 +0800"
Message-ID: <otu2k6tn9h.fsf@thinktwice.zoftcorp.dk>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "dony" == dony  <dony.he@huawei.com.cn> writes:

dony> Hello,

dony>        Now I want to use gdbserver to debug my test app.
dony> Running "gdbserver :6666 ./mytest" on the target (Powerpc 860)
dony> show a message: Process ./mytest created :pid=8 But I don't know
dony> how to run gdb on the host (X86). The README doesn't seem to
dony> explain clearly . It says first running "gdb mytest" on the host
dony> and then "target remote mytarget:6666".  But I don't understand
dony> something about "gdb mytest" . At this time should I run a x86
dony> "gdb" or something like "powerpc-linux-gdb"? And the "mytest"?


mytest is the same executable you run on the target. gdb you run on
the host would be powerpc-linux-gdb (i.e., cross-debugger), thus:

target:> gdbserver :6666 ./mytest

host:> powerpc-linux-gdb mytest
[...]
(gdb) target remote mytarget:6666




dony> Is it compiled with x86 gcc or cross-compiled with
dony> "powerpc-linux-gcc"? Really I am very confused at this point:-((

mytest is compiled with powerpc-linux-gcc.

dony> Do you have any experience to share with me about how to build
dony> and run gdbserver?  Or do you have any other debug tools which
dony> can be used in embedded-linux environment?  The README for
dony> gdbserver is written by Stu Grossman and Fred Fish.  Does
dony> someone know their email address?  Thank you very much:-) dony

Yes I know their email addresses. But you don't want to hassle them
with this. Trust me :)

Jesper

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
