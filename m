Message-Id: <200003272001.PAA28490@mal-ach.watson.ibm.com>
To: Ani Joshi <ajoshi@shell.unixbox.com>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Some issues to resolve with XFree 4.0 yet 
In-Reply-To: Message from Ani Joshi <ajoshi@shell.unixbox.com>
   of "Mon, 27 Mar 2000 11:38:37 PST." <Pine.LNX.4.10.10003271136400.10993-100000@shell.unixbox.com>
Date: Mon, 27 Mar 2000 15:01:20 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Ani Joshi writes:

Ani> So does this mean all drivers (atyfb, aty128fb, xpmac to name a few) which
Ani> use method "b" should change to "a"?

	In general, I think that it is recommended that inline assembly
use exact constraints and not "memory".  "memory" clobber is intended for
inlined assembly implementing something like memcpy().  Even the GCC
inline asm tutorial from April 1988 uses "=m" constraints which are not
referenced in the output template.  For a more definitive statement, I
think that you should ask on the gcc@gcc.gnu.org mailinglist.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
