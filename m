Message-Id: <200104241448.KAA65870@p2.parker.boston.ma.us>
To: linuxppc-embedded@lists.linuxppc.org
Subject: linuxppc_2_5 tree with -g?
Date: Tue, 24 Apr 2001 10:48:41 -0400
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I tried to add -g to my kernel cflags on the linuxppc_2_5 tree the other day.
The resulting file would not load on my BSE platform;  There was a missing
strip on the loader.  I've since seen some odd crashes, etc...

Did I do something wrong or should this work?  Seems to me it should work.

-brad

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
