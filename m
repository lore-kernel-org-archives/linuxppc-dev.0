Message-ID: <1072F1A27E99D3119747005004B9A3804157C8@MAIL>
From: Rodney Davies <rodneyd@nulec.com.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Patch for arch/ppc/kernel/head.S - require version update
Date: Fri, 28 Apr 2000 09:26:39 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I'm currently in the process of trying to patch the 2.2.13
/arch/ppc/kernel/head.S file with Jason's update (11/04/2000)(see below),
however, I have a much older version of head.S than what the patch is
expecting --

I have -
$Id: head.S,v 1.130.2.6 1999/10/12 01:03:34 Cort

The patch says -
- $Id: head.S,v 1.1.1.1 2000/01/03 15:56:48 jason Exp $
+ $Id: head.S,v 1.4 2000/04/11 18:59:54 jason Exp $

I am also patching the kernel for an MPC850/RPXLite board.

Could anyone please inform me as to where I should be looking for the
updates between 1999/10/12 and 2000/01/03 ??
...or could I be really dangerous and fudge the current head.S file I have
to make the new patch *think* it's the 2000/01/03 version....I really don't
have a clue as to what changes/additions/subtractions that have taken place
between October and January...

Thanks all!

Cheers,
Rod

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
