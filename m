Message-Id: <200010310649.HAA00860@piglet.grunz.lu>
Date: Tue, 31 Oct 2000 07:49:32 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2.2.18pre17 again
To: paulus@linuxcare.com.au
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <14839.53124.753011.489351@argo.linuxcare.com.au>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Paul.

On  26 Oct, this message from Paul Mackerras echoed through cyberspace:
> I have updated my rsync trees with some more changes to my current
> 2.2.18pre17 source

There are a few patches on sourceforge that you might consider for the
2.2.18 kernel release:

- per-fb mmap for controlfb: this one has worked well for everybody who
tested it, and gives a decent speed increase:

https://sourceforge.net/patch/?func=detailpatch&patch_id=101236&group_id=8234

- better processor configuration in head.S. This is basicallz a copz of
  what is already done in 2.4:

https://sourceforge.net/patch/?func=detailpatch&patch_id=101403&group_id=8234

- macserial proc additions and cleanups:

https://sourceforge.net/patch/?func=detailpatch&patch_id=101410&group_id=8234

- ICTC support in the sysctl interface:

https://sourceforge.net/patch/?func=detailpatch&patch_id=101484&group_id=8234

- kernel compilation independant of the /usr/src/linux path (however,
  this patches the top-level Makefile as well...):

https://sourceforge.net/patch/?func=detailpatch&patch_id=101549&group_id=8234

I have one or two other things (not of any particular importance); if I
get around to making a patch in the next days, I'll send them along.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
