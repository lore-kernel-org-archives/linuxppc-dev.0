Date: Sat, 31 Aug 2002 00:56:09 -0500
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Shift keycodes on the iBook
Message-ID: <20020831055609.GC30659@elb.d2g.biz>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I have come across this issue several times in the past, and it has
never been a show-stopper for me ... but now it is more painful.

The Linux kernel does not seem to differentiate between several of
the keys on the iBook (iceBook in this case) keyboard that are
differentiable on most platforms...  For instance (my current
problem), the left and right shift keys both return a left shift
keycode.  (Ditto for the command key, same keycode for both.)
Unfortunately I am in the situation of needing to set up an iBook for
a Russian user who is used to using a shift+shift chord to change
character sets (apparently this is quite common) ... since the iBook
produces the same keycode for both keys, there is no way to produce
this chord.  I can use a different method (for instance I currently
have her using the caps lock key to change mappings), but it isn't
what she is used to.

Is this a hardware limitation, or just a limitation of the current
maps?  If it is the latter, can it be easily fixed?  I'm willing to
provide whatever information is necessary if the problem is just that
the appropriate developer needs information about the iBook keyboard.

Thanks for your time,
Ethan
--
Now if I wasn't such a weenie do ya think you'd still love me,
Pretendin' I'm an airplane on the living room floor?
                -- The Offspring, "I Choose"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
