Date: Tue, 26 Feb 2002 12:17:27 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200202262017.g1QKHR904656@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The problem is related to CONFIG_VT. If CONFIG_VT is set, the problem happens.
If CONFIG_VT isn't set, the problem doesn't happen, or doesn't happen as
often.
2.4.10 CONFIG_VT = off, no problem
2.4.14 CONFIG_VT = off, no problem
in both cases if I turn CONFIG_VT on, the mmap problem manifests itself.

2.4.17 CONFIG_VT = on, CONFIG_FB = off, CONFIG_INPUT = off, mmap program
   fails after 12 iterations
2.4.17 CONFIG_VT = off, CONFIG_FB = off, CONFIG_INPUT = off, mmap program
   fails after 6000+ iterations.
2.4.17 CONFIG_VT = on, CONFIG_FB = on, CONFIG_INPUT = on, mmap program
   fails after 228 iterations.

This is really a puzzler to me.
-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
