Message-Id: <200006050601.IAA01779@piglet.grunz.lu>
Date: Mon, 5 Jun 2000 08:01:29 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: [patch] VRAM detection in controlfb
To: geert@linux-m68k.org
cc: toe@unlserve.unl.edu, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.05.10006030855010.1278-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On   3 Jun, this message from Geert Uytterhoeven echoed through cyberspace:
> Immediately after I read this, I thought: isn't that already implemented
> through fbmem.c? Then I remembered that controlfb is initialized from offb, and
> not directly from fbmem_init().
>
> I looked at the source, and surprise, controlfb can also be initialised on its
> own:
(patch deleted)

I applied the patch; XF4 works (just as badly) as before, but Xpmac
crashes big-time (panic on access of bad area (9C9C9D9D, iirc). makes
syslogd panic as well ??). But it started misbehaving already before
your patch, so there is probably something else as well...

I'll keep on looking.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
