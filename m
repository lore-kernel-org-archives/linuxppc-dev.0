From: Benjamin Herrenschmidt <bh40@calva.net>
To: "Timothy A. Seufert" <tas@mindspring.com>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MacOS X and yaboot wars.
Date: Sat, 23 Sep 2000 12:16:00 +0200
Message-Id: <19340818034744.27131@192.168.1.10>
In-Reply-To: <v04220800b5f21601b44d@[10.0.0.42]>
References: <v04220800b5f21601b44d@[10.0.0.42]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Interestingly enough, I noticed this tidbit in their BootX script:
>
>-------------------------------------------
>if 0 0 then
>
>
>
>
>
>
>
>
>
>
>
>-------------------------------------------
>
>Implying that they may be doing something with ext2 support.

You "tidbit" was empty ;)

They have indeed ext2 support in their "BootX". They have ELF support.
They have almost everything needed to boot the Linux kernel as well. I
need to implement the necessary support in the kernel itself to get it
working.
>
>The only major problem I've got is that whenever I boot plain old
>MacOS by itself, it ruthlessly deblesses the MacOS X partition,
>rendering it unable to boot.  I have to use System Disk if I want to
>boot into MacOS X again, and since it blows away my boot-device
>setting I have to force the machine into OF to set it again if I want
>to use the ofboot boot menu.  Annoying, but not a new problem.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
