Message-ID: <3B97DA58.6894B342@acm.org>
Date: Thu, 06 Sep 2001 13:19:36 -0700
From: Ira Weiny <iweiny@acm.org>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Cardbus issues on TiBook
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


As some of you may know I am trying to get an IBM microdrive working on
my TiBook.  I know there is an issue with irq's which I am trying to
work out but I have run into another issue I don't understand.

I get the following message in my startup:

kernel: Can't get bus-range for /pci@f2000000/cardbus@1a

I rsync'ed with Ben H's kernel recently and I found that the ioports and
memory ranges I had set for cardmgr were not working anymore.  So I
started changing them.  In my efforts to find ranges that worked I found
that "cat /proc/ioports" would result in a segfault.  From what I can
tell it is running off the end of the buffer in vsnprintf?

Before the Cardbus modules are loaded "cat /proc/ioports" works fine.

So my question is, what does the above message mean?  It is something
which is worked around later, or could it be the root of my problem?

Thanks,
Ira Weiny
iweiny@acm.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
