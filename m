Date: Tue, 24 Feb 2004 12:09:01 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Anyone using uClibc on a 405GP platform?
Message-ID: <20040224110901.GB2970@tmathiasen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Does anyone successfully use uClibc on a 405GP platform? I tried compiling
uClibc but all my dynamic apps just segfault. Its the shared library loader
that segfaults immediately after execve(). I tried both a recent 2.4 and 2.6
kernel with the same result. Also using latest 0.9.26 uClibc.

Has anyone gotten this to work?

On my i386 platform uClibc works very well.

Thanks,
Torben
--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
