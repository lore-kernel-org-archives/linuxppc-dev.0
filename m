Date: Fri, 12 May 2000 13:34:56 -0500 (CDT)
From: David Weis <djweis@plconline.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: some booting help
Message-ID: <Pine.LNX.4.10.10005121331400.13573-100000@catbert.desm.plconline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We've started again with the MCA rs/6000's and I needed a bit of help. A
little background on the machine-
It's a rs6000 7011-250 with a 601 PowerPC processor
The io ports on the MCA bus are addressed through a bus unit controller
with a BUID of 0x20. If I wanted to write something to 0x3f8 on the mca
bus, I would have to set up the segment register, etc, correct? Is this
something with enough overhead that I can't realistically do it for every
io port access?

We do have some code by Andrew Richardson that will make a valid boot disk
and print 987 to the display on the front. It's available at
http://www.sjdjweis.com/bboard/q-and-a-fetch-msg.tcl?msg_id=000005&topic_id=1&topic=RS%2f6000%20Linux

Any help is appreciated!

dave


--
David Weis                | 10520 New York Ave, Des Moines, IA 50322
djweis@plconline.com      | Voice 515-278-0133 Ext 231
                          | http://www.perfectionlearning.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
