Message-Id: <200104171423.QAA00813@piglet.grunz.lu>
Date: Tue, 17 Apr 2001 16:23:21 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Quad SMP on G4
To: peter@llama.nslug.ns.ca
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010417040346.C15047@llama.nslug.ns.ca>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  17 Apr, this message from Peter Cordes echoed through cyberspace:
>  When these came up, the keyboard was half functional.  I could switch
> consoles, scroll back, and use the magic sysrq key.  Regular typing doesn't
> produce any characters on screen, so of course I couldn't log in.  I could
> ping and make TCP connections, but user space sshd doesn't answer, so the
> connection hangs.

I've had a similar symptom (some key combos work, like console
switching, but not typing, and no new process like a telnetd can start)
on my TiBook, which is obviously not SMP, and doesn't run a SMP kernel.

Maybe the problem here si something else?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
