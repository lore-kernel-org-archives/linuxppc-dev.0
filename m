From: Benjamin Herrenschmidt <bh40@calva.net>
To: Martin Costabel <costabel@wanadoo.fr>,
        linuxppc-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 problems
Date: Thu, 31 Aug 2000 23:47:24 +0200
Message-Id: <20000831214724.8428@192.168.1.10>
In-Reply-To: <39AEC1C7.E0894CFB@wanadoo.fr>
References: <39AEC1C7.E0894CFB@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>On my 6400, both bk-test8 and pmac-devel-test7 are running nicely. The
>one major problem is random sudden freezes that can happen after some
>minutes or after 3 days and which have been reported a couple of times
>by others, too. It is like the ADB interrupt dies. There are no
>messages, the computer is still alive, it goes on compiling or
>downloading, and today I even could ssh in over the net, but locally,
>keyboard and mouse are dead, even MagicSysRq, the only working key combo
>is ctrl-cmd-power :-(
>
>I never saw this with 2.2.X kernels (not recently, in any case).

Interesting. Do you have the new input layer enabled or are you still
running the old keyboard and mouse drivers ? If you telnet to the box, do
you still see ADB interrupts increasing when typing keys or not ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
