Message-Id: <200107050550.HAA00737@piglet.grunz.lu>
Date: Thu, 5 Jul 2001 07:50:13 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Kernel crash with BenH' tree (was: Re: __divdi3...)
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010704200508.4967@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On   4 Jul, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>Finally my kernel 2.4.6-pre6 (benh) still does not boot on my tibook
>>but problem must be elsewhere now.
>
> My current rsync should boot the tibook. Please give it a try using
> the included .config and tell me, I plan to do a binary release of
> that kernel.

Leave out the Thermal Management then (like it's done in your .config):
that seems to be the culprit for the recently reported crashes on the
TiBook. Just compared your 2.4.6 with and without Thermal: it's quite
clear ;-)

Haven't looked at why that is so, however.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
