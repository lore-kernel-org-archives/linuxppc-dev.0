Message-Id: <200009160921.KAA19271@hyperion.valhalla.net>
Date: Sat, 16 Sep 2000 10:21:49 +0100
Subject: Policy on "one size fits all" builds
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a (small) dilemma.

discussion relates to dmasound driver (but prop relates elsewhere).

The idea of :

"one size fits all" compiles

is in direct conflict with:

"I want to build the smallest version and don't want to look for any
hardware I know I don't have".

for example, I can put wrappers round the cuda usage in dmasound_awacs that
will prevent it being compiled in if someone switches off CONFIG_CUDA (it
has already been done at 2.4.0 by someone).

So.  Should I wrapper or should available resources be probed at run-time?

(I don't mind which way I do it - but I'd like some guidance from those who
ultimately determine what is acceptable)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
