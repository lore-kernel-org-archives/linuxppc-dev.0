Message-ID: <3973B620.6515067F@ivey.uwo.ca>
Date: Mon, 17 Jul 2000 21:42:56 -0400
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: _linux.cfg file is wrong for powerpc in Mozilla builds
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


To (Whomever supports Mozilla on PowerPC).

I have been trying to trackdown a bug with the forthcoming jdk 1.3 oji plugin
for Mozilla (that will give mozilla full java capabilities).  It seems the
plugin relies on the libnspr4.so shared lib provided by the mozilla source
tree.  I noticed that the _linux.cfg file that is used to generate prcpucfg.h
has the wrong alignment constraint for both int64 types and doubles.

They are both set to 4 now and they should be 8.  Also the proper
HAVE_ALIGNED_XXXXX definitions should be set for powerpc.

This causes problem with pipes and things and some of the unions that are used
in the code.

Will whomever is supporting Mozilla on Linux PowerPC please check out _linux.cfg
found in the nsprpub directory tree and get this fixed.

Thanks,

Kevin


ps. I checked and the problem is still in the nightly builds.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
