Message-ID: <00c501c124fc$4b3fb770$2408a8c0@dnaent.com>
From: "William H. Short, Jr." <bshort@dna-cs.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: NFSROOT will not work on MY G3 dual
Date: Tue, 14 Aug 2001 15:04:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am working with a DNA VQ750 board running SMP with two processors.  If I
try to boot from ram drive board works great.  I then try mounting and that
works AS LONG AS you use the 'nolock' option.  However, if I compile to boot
NFSROOT it gets to the end just before INIT: and hangs.  Sometimes it prints
kernel stack overflow in some translated address that doesn't really tell me
anything.  I just downloaded 2.4.9p3 and all results are the same.  Also
note that if I remove SMP support it works just fine.  This seems to be a
problem with the NFS support on SMP.  Are there any known problems?  Does
anyone have an idea?
Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
