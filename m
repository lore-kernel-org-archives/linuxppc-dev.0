Message-Id: <200009132025.WAA00853@piglet.grunz.lu>
Date: Wed, 13 Sep 2000 22:25:15 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: success 2.4.0-test8 with latest bk
To: bh40@calva.net
cc: costabel@wanadoo.fr, paulus@linuxcare.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000913124700.2558@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  13 Sep, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>Update: After a recompilation with today's updates, the latest bk kernel
>>boots again for me.
>
> That's not the first time I notice this strange behaviour. I meant, this
> happened to me randomly with various bk kernels for monthes. The problem
> usually disappeared by itself after either recompiling the entire kernel,
> or changing a few unrelated lines of code and then reompiling. That's
> weird, I really don't know what can be causing that.

Same for me, except that for a few weeks now I'm basically stuck in a
non-booting mood. One out of roughly 20 tries boots indeed; all the
other stop in various places in init/main.c. Not even going into xmon...

Since it doesn't seem to be a reproducible crash in one specific place,
its rather hard to isolate the problem. I feel like chasing ghosts...
Anybody got Ghostbusters' phone?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
