Message-ID: <392E1FCB.64381A5@huawei.com.cn>
Date: Fri, 26 May 2000 14:55:08 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-embedded post <linuxppc-embedded@lists.linuxppc.org>
Subject: app or shell hangs...
References: <D53137D1F3DDD211A3750800060DA31302B2CCCD@viee122a.erd.siemens.at> <392D6561.1B8E04BC@embeddededge.com> <392D8E10.BE49DB66@motorola.com> <392D92D5.43881EFD@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:
        Now I can boot kernel both from Network or from Flashrom. But there are
problems.

[boot from Network]
        When I download the kernel via TFTP at 0x400000 ,then go there to run
it:
                     .........
                    VFS: Mounted root (ext2 filesystem).
                    Freeing unused kernel memory: 28k init
        As you see here, occasionally it can not even show the bash prompt
"bash#", and at this time  any input on the Win98 SuperTerminal has no effect.
        But most of the time it can show "bash#", and at this time I can do
"ls" "cd" etc, but after a certain time  when I type any commands ,the Win98
SuperTerminal doesn't response and cannot show the character I just type any
more. It seems that it cannot receive input via SERIAL port.
        And If I run an application which will print some debug information all
the time , it will also hang after a certain time(But it should not so in
theory).
       So I suspect either the kernel  is not stable or something is wrong with
my bootrom.
       The kernel I use is MPC8xx-2.2.13, I have modified it to suit my
purpose(uart.c enet.c). But
to my surprise, When I  use VxWorks bootrom to TFTP download the same kernel
and
run it, it doesn't have all the above problem. It works well. So  the kernel
should be stable.

[Boot from flashrom]
        It has the same symptom as the above.

Does  someone has similar problem? and what's the solutions?

        Another question I want to ask is: When you download the kernel via
TFTP or copy from flashrom to RAM 0x400000 , Do you do SOMETHING SPECIAL ELSE
(about 860) and then jump there 0x400000 and run it, Or do you DIRECTLY jump
there 0x400000 and run it?
        Can you give me any suggestions?
        Thanks very much.
        dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
