Date: Wed, 4 Feb 2004 21:29:34 +0100 (CET)
From: Mich Lanners <mlan@cpu.lu>
Reply-To: Mich Lanners <mlan@cpu.lu>
Subject: Re: Video For Linux on ppc32 in kernel 2.6
To: olh@suse.de
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Message-Id: <E1AoTeQ-0003HK-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Olaf,

On   4 Feb, this message from Olaf Hering echoed through cyberspace:
> CONFIG_VIDEO_DEV triggers CONFIG_VIDEO_BUF. If compiled as module,
> video-buf.c wants clear_user_page(). This is a define on most archs
> (maps to clear_page()), on ppc32 it is an unexported function. This
> leads to unresolved symbols.
[snip]

Thanks for pointing this out; one less problem for me to worry about
should I ever get to update planb :-)

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
