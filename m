Message-ID: <3AF3551D.3627FFBC@acm.org>
Date: Fri, 04 May 2001 18:19:25 -0700
From: Ira Weiny <iweiny@acm.org>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: ieee1394 status
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anything more been done on the ieee1394 since March?  Back then
there was a big discussion about some patches and fixes for endianess.
Did these make it into Ben's rsynced tree?

I am trying to do some work with 1394 on my Titanium and it seems to
self id correctly but there are problems when trying to read from the
bus.  I am assuming a problem in the OHCI driver since my G3 did not
have these problems last night with the pcilynx driver.  (And I can't
verify that until next week when I get back to it.  Sorry)

Should I dig into this further?  Is there a tree with newer 1394 code in
it?
Ira


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
