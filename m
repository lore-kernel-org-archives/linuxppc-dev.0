Message-Id: <200102060654.HAA00731@piglet.grunz.lu>
Date: Tue, 6 Feb 2001 07:54:34 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: long delays in drivers.
To: iain@sandoe.co.uk
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010204031946.58FDD2F04E@apollo.valhalla.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   4 Feb, this message from Iain Sandoe echoed through cyberspace:
> if I need to implement a long delay (say 1 second) in the initialisation of
> a driver... what is the best mechanism to use to ensure that resources are
> not wasted?

Use a waitqueue. Relativly easy to implement....I can dig out an example
at work, if you need it. Just let me know.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
