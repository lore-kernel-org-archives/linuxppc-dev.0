Message-Id: <200108200602.IAA00834@piglet.grunz.lu>
Date: Mon, 20 Aug 2001 08:02:16 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Task Queue Imediate Bottom Halfs question.
To: iweiny@acm.org
Cc: linux1394-devel@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3B803FEE.7079F34C@acm.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  19 Aug, this message from Ira Weiny echoed through cyberspace:
> So, my question is, why use a bottom half here?  Or really what is the
> difference between scheduling a task queue (tasklet) imediate vs just
> running the code in the IRQ handler?

Have a look at Documentation/DocBook/kernel-hacking.tmpl.

It explains some of these things quite well, I think.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
