Message-Id: <200010041115.NAA00715@piglet.grunz.lu>
Date: Wed, 4 Oct 2000 13:15:29 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: l2cr function corrections for G4 (attached now)
To: bh40@calva.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19340828165801.6685@192.168.1.10>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   4 Oct, this message from Benjamin Herrenschmidt echoed through cyberspace:
> _get_L2CR was indeed bogus (your patch doesn't seem to change _set_L2CR
> or am I blind). Nice catch.

Only cosmetically. The bug in _get_L2CR wasn't present in _set_L2CR.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
