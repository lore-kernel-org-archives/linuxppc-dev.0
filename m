From: clark@esteem.com
Message-Id: <1.5.4.32.20001013211654.006b8e44@pop.esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 13 Oct 2000 14:16:54 -0700
To: linuxppc-embedded@lists.linuxppc.org
Subject: Is there a newer pcmcia package for HardHat 1.2
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

        Is there a newer pcmcia package for HardHat 1.2? I have obtained
pcmcia-cs-3.1.10 and a patch to make it work with HardHat 1.0 . However when
I compile it to work with HHL 1.2 I get the following message on each module.

{standard input}: Assembler messages:
{standard input}:6: Warning: Ignoring changed section attributes for .modinfo

It does compile and I think it may work (I don't know because we have not
put the chips on the board we are trying to talk to yet ). It loads and
shows up in the /proc/modules . Should I just ignore this message?

        Any help welcomed. Thanks in advance.

        Conn Clark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
