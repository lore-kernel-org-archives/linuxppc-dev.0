Date: Sat, 30 Mar 2002 17:25:48 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: crash on sleep with 2.4.19-pre4-ben0
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020328141439.20362@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E16rLfu-00009C-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  28 Mar, this message from benh@kernel.crashing.org echoed through cyberspace:
>>How? The keyboard doesn't work under xmon.... I need to power-cycle.
>
> You can try manually adding a call to backtrace() in xmon entry point

AAArrgh! It doesn't crash anymore now! Thanks for the solution ;-))).

Seriously, after adding a call to backtrace upon entry of xmon's main
(infinte) loop, I've not been able to reproduce the crash. And I tried
sleeping and waking up in a loop at least 50 times...

I'll keep on trying.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
