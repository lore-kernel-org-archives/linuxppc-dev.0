Message-Id: <199912160653.HAA00308@piglet.grunz.lu>
Date: Thu, 16 Dec 1999 07:53:20 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Bug in X 3.3.5
To: dorland@lords.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19991215202647.A503@HSE-MTL-ppp4549.qc.sympatico.ca>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  15 Dec, this message from Eric Dorland echoed through cyberspace:
> 
> I've noticed a problem for a while in X. When I've got a lot of disk i/o
> going on, and then move the mouse, sometimes false mouse button 3 down
> events are sent to the server. I don't really understand why this is
> happening, but it only happens with a lot of disk i/o.

I guess this has something to do with the ADB driver not getting enough
processor time to do its job. I've never seen it on my setup, though
(7600 with R4 and Xpmac-mga, official kernel 2.2.13)..

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
