Message-Id: <200001201851.NAA26974@mal-ach.watson.ibm.com>
To: Benjamin Herrenschmidt <bh40@calva.net>,
        Kevin Hendricks <khendricks@ivey.uwo.ca>
Cc: Moritz Thomas <motho@gmx.net>, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
In-Reply-To: Message from Benjamin Herrenschmidt <bh40@calva.net>
   of "Thu, 20 Jan 2000 19:45:07 +0100." <20000120194507.014220@mailhost.mipsys.com>
Date: Thu, 20 Jan 2000 13:51:39 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Hum... I still have to check what gcc/ppc specific constraints are. But
> in this specific case, it's the index who should not be assigned to r0.
> Both base and regdata can be r0. So either I'm mising something, or the
> "b" constraint is actually wrong semanticall, or we need yet-another
> constraint for the index.

	Sorry, you are right.  I am multitasking on too many things.  The
way that you have written the inlined assembly, regindex should be the one
with the "b" constraint.

	Also, Geert's comment was correct that there is no difference in
the example function simply because of luck.

Sorry, David
===============================================================================
David Edelsohn                                      T.J. Watson Research Center
dje@watson.ibm.com                                  P.O. Box 218
+1 914 945 4364 (TL 862)                            Yorktown Heights, NY 10598

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
