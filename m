Message-ID: <20000222195013.10038.qmail@web1703.mail.yahoo.com>
Date: Tue, 22 Feb 2000 11:50:13 -0800 (PST)
From: Gabriel Ricard <g_ricard@yahoo.com>
Subject: Strange Issues with Lombard & PMU/PMUD
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, I've got a Lombard 400MHz running 2.2.15pre6,
pmud-0.3pre1 on top of YDL Champion Server 1.1. I can
put the system to sleep using Batmon (that came with
pmud) or by closing the lid. It comes out of sleep
just fine when I hit a key, except for resetting the
trackpad options I had previously set, but that is a
documented bug already.

Anyways... After it comes out of sleep I have some
issues with X and GTK, possibly with Enlightenment,
I'm not sure. Here's what happens:

- come out of sleep

- click on the virtual desktop in the gnome panel
pager applet that contains gEdit.

- scroll down a document in gEdit using the arrow key

- regardless of how many times I hit the key it seems
to scroll all the way down

- gtk becomes unstable
        - mouse_over type events are ignored
        - mouse clicking anywhere seems to be
ignored..

- system monitor panel applet works fine so I know I
haven't locked up.

- cannot click on anything... X is unresponsive to the
mouse (trackpad mouse, or external Intellimouse
Explorer)

At this point if I close the powerbook to put it in
sleep mode and then open it back up and wake it up it
comes back and X is fine.

I have no clue what's going on here, nor how to
properly debug it. If someone would be willing to help
me figure this out I'd greatly appreciate it. It's not
a huge deal, just a minor annoyance since I don't put
my PB to sleep all that much.


=====
Gabriel Ricard
g_ricard@yahoo.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
