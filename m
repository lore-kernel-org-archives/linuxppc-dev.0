Message-ID: <3889220B.2BD1CB63@huawei.com.cn>
Date: Sat, 22 Jan 2000 11:20:43 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: gdbserver
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

       Now I want to use gdbserver to debug my test app.
      Running "gdbserver :6666 ./mytest" on the target (Powerpc 860)
show a message:
                    Process ./mytest created :pid=8
      But I don't know how to run gdb on the host (X86). The README
doesn't seem to explain
clearly . It says first running "gdb mytest" on the host and then
"target remote mytarget:6666".
But I don't understand something about "gdb mytest" . At this time
should I run a x86 "gdb" or something like "powerpc-linux-gdb"? And the
"mytest"? Is it compiled with x86 gcc or cross-compiled with
"powerpc-linux-gcc"? Really I am very confused at this point:-((
       Do you have any experience to share with me about how to build
and run gdbserver?
Or do you have any other debug tools which can be used in embedded-linux
environment?
        The README for gdbserver is written by Stu Grossman and Fred
Fish.
        Does someone know their email address?
Thank you very much:-)
dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
