Message-Id: <200006040709.JAA00760@piglet.grunz.lu>
Date: Sun, 4 Jun 2000 09:09:24 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: [patch] VRAM detection in controlfb
To: Franz.Sirl-kernel@lauterbach.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <00060311160100.00693@enzo.bigblue.local>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Franz,

On   3 Jun, this message from Franz Sirl echoed through cyberspace:
[hacking controlfb]
> if you don't mind, would you try to replace the "dcbi" assembler instructions
> in the detection code with "dcbf" instructions? It seems Dan inherited my bug
> I had in the platinumfb driver...

Sure, no problem.

In what sense is that a bug, and what would be the symptom? I know close
to nothing about PPC assembler, and fully understanding the detection
code might help fix the detection problems we still have in some
situations...

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
