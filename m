Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C07F36B.C82F4B57@lvl7.com>
Date: Fri, 30 Nov 2001 16:00:27 -0500
From: "John W. Linville" <linville@lvl7.com>
MIME-Version: 1.0
To: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: mpc860p specific patches?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Forgive me if this is a stupid question, but...  I'm wondering if there
are any patches specific to using an MPC860P (note the "P") with a 2.4.x
kernel?

I've got 2.4.14 configured for an MPC860T, and I seem to get corrupted
packets over the FEC.  I haven't quite narrowed down whether this is
related to how many packets are received or the size of the packets...

I'm not reseting the CPM in my embed_config() function.  Perhaps I need
to?

Has anyone seen/heard of a problem like this with the 860P?  I have the
same problem on a 2.2.16 kernel using the same boot code.

Thanks,

John

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
