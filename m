Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: overnight 2.4.11 seems to have used up all memory, slow as a dog
Date: Mon, 8 Oct 2001 07:30:21 -0400
MIME-Version: 1.0
Message-Id: <20011008112806.PUYY27768.tomts5-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I realize this is a vague bug report but since I am new to the 2.4.X
kernel series perhaps someone could enlighten me:

I am running a benh_kernel rsync from yesterday.

I downloaded XF4.1.0 and started the build and went to bed.

In the morning I came down and everything was still functioning but
painfully slowly.  So slowly as to make every command painful to watch.

Everything seemd to be hittng the disk but "top" showed nothing unusual.
It was like a was all out of memory.

Is this a symptom of the "VM" troubles that have kept me away from the
2.4.X series?

How can I track this one down?

FWIW, this never happens with 2.2.19 at all (I can do long overnight
builds with no trouble with no slowdowns.

Ideas anyone?

I am already starting to hate the 2.4.X kernels ;-)

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
