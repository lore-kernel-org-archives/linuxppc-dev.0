Message-ID: <388BB007.D0BF32C4@huawei.com.cn>
Date: Mon, 24 Jan 2000 09:51:04 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Jesper Skov <jskov@cygnus.co.uk>,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gdbserver
References: <3889220B.2BD1CB63@huawei.com.cn> <otu2k6tn9h.fsf@thinktwice.zoftcorp.dk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




Jesper Skov wrote:

> >>>>> "dony" == dony  <dony.he@huawei.com.cn> writes:
>
> dony> Hello,
>
> dony>        Now I want to use gdbserver to debug my test app.
> dony> Running "gdbserver :6666 ./mytest" on the target (Powerpc 860)
> dony> show a message: Process ./mytest created :pid=8 But I don't know
> dony> how to run gdb on the host (X86). The README doesn't seem to
> dony> explain clearly . It says first running "gdb mytest" on the host
> dony> and then "target remote mytarget:6666".  But I don't understand
> dony> something about "gdb mytest" . At this time should I run a x86
> dony> "gdb" or something like "powerpc-linux-gdb"? And the "mytest"?
>
> mytest is the same executable you run on the target. gdb you run on
> the host would be powerpc-linux-gdb (i.e., cross-debugger), thus:
>
> target:> gdbserver :6666 ./mytest
>
> host:> powerpc-linux-gdb mytest
> [...]
> (gdb) target remote mytarget:6666
>
> dony> Is it compiled with x86 gcc or cross-compiled with
> dony> "powerpc-linux-gcc"? Really I am very confused at this point:-((
>
> mytest is compiled with powerpc-linux-gcc.

"powerpc-linux-gdb" is compiled with gcc or powerpc-linux-gcc?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
