MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14802.18291.902553.42491@esb.bbn.com>
Date: Wed, 27 Sep 2000 15:16:03 -0400
From: R Shapiro <rshapiro@bbn.com>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        daenzerm@student.ethz.ch, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <Pine.LNX.4.10.10009272059060.9291-100000@zirkon.biophys.uni-duesseldorf.de>
References: <14802.16462.166588.375647@esb.bbn.com>
	<Pine.LNX.4.10.10009272059060.9291-100000@zirkon.biophys.uni-duesseldorf.de>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz writes:
 > S**t. I overlooked that. Ok, I officially declare the ati driver unable to
 > cope.

Just to mention: the ati driver *does* work on my other G3, a
single-monitor rev. b Rage Pro running the same XFree 4.0.1 (different
kernel though).  Is it useful to see the log for that one?  I notice
that it's throwing away the mode I got from fbset -x and using one of
the built-in modes instead.  It also gets a silly value back from the
vram probe:

(--) ATI(0): VideoRam: 3 kByte (EDO)


But it runs ok, at least so far.

--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
