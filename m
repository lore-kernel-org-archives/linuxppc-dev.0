Message-Id: <200006261623.RAA10793@hyperion.valhalla.net>
Date: Mon, 26 Jun 2000 17:19:56 +0100
Subject: Kernel profiling and sound
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi List,

One of my main interests is in using linuxppc for DSP/Audio related tasks.

I am on the ALSA & audio-dev lists and there has been a lot of discussion
about achieving low-latency audio I/O.

Could anyone enlighten me as to the state of this topic wrt the linuxppc
kernels?  It seems to be almost exclusively x86-related.

Specifically:

How does one profile the kernel?

Is there anyone (else) on the list who is trying to do the same kind of
thing?

Has anyone tried applying the low-latency patches (Ingo's) to *any* ppc
kernel?

does the ppc 2.4 kernel suffer from the (reported) VM issue that causes it
to exhibit *more* latency than 2.2.x kernels (this is the ststus of x86)?

I'm sure I'll have more questions soon...

TIA,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
