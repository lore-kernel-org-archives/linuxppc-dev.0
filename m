Message-Id: <200108110647.IAA00781@piglet.grunz.lu>
Date: Sat, 11 Aug 2001 08:47:04 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Compiling EIDE patch on PPC
To: mfedyk@matchmail.com
Cc: bob@kunk.jriver.com, debian-powerpc@lists.debian.org,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010810161714.E28914@mikef-linux.matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  10 Aug, this message from Mike Fedyk echoed through cyberspace:
> OK, I've been able to compile it successfully.  Changes included.

Good.

> I haven't booted the kernel yet.  Can someone take a look at the patch to
> see if I may have made any bad changes?

Well, if it compiles and works like that, than it should be OK. You only
changed #include's, after all...

> Maybe the actual files in asm-ppc should be changed instead?

Which ones are you refering to? You only changed .c files; no header
files. Under asm-ppc, there are only header files.....

> If it is good, I'll send it to Hedrick for the
> next patch release.

Looks good to me. THough I am a bit surprised by you being able to
remove asm/ide.h from generic IDE driver files...

> Also, there is an include for asm/ide.h in apus_setup.c.  I didn't change it
> because I don't have any prep machines for testing, and for some reason it is
> also including from the m86k arch.

APUS is not PREP, its some Amiga stuff. Basically, originally 68k-Amigas
upgraded with PPC processors; so no wonder they're a hybrid of m68k and
ppc ;-). I would _guess_ they need the <asm/ide.h> replaced by
<linux/ide.h> too.

> Michel, I'm going to do another compile with your pci-fixup patch.  Do you
> have any idea if it is needed on 7200, 6500, or oldworld g3 powermacs also?

I never tested it there; but since the problem (for your IDE card) is
with access to PCI IO ports, _any_ ppc 2.2 kernel would suffer from that
problem, independant of the precise hardware.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
