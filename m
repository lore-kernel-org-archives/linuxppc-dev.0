Message-Id: <1071065435.2238948984@as03.coolgoose.com>
From: "Nikhil Bhargava" <nikhilbhargav_nsit@coolgoose.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: testing mechanism for protocol stack
Date: Wed, 10 Dec 2003 06:10:35 -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello,

I am looking for a test plan to test my protocol stacks. I am
developing protoco stacks for umts network (http://www.3gpp.com).

My purpose it to first test the entire stack (all layers) on a single
host and then cross compile the binary of the stack and port it to any
target development board and target test the protocols on it for actual
performance testing.

Presently I am integrating all layers of one of the stack on to a
single stack. I need a test plan for it. Precisely,

1. Tools which help in tracking memeory leakes, stack flow and
efficiency testing on host itself

2. Mechanism or suggestions for testing any generic stack on a host
environment. ( some documents or web material).

3. Suggestions for target testing the protocol stacks on the
development board.

I am currently evaluating some protocol analyzers and some freeware
tools. Any suggestions would be highly appreciated.



nikhil
Cheers,

Nikhil Bhargava,
Research Engg.,
IMT-2000,
Center of Development of Telematics, CDOT,
India.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
