Date: Thu, 10 Oct 2002 17:22:28 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Problems with linuxppc_2_4_devel
From: Anders Blomdell <anders.blomdell@control.lth.se>
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <16403444-DC64-11D6-99DE-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm still unsuccessful with running linux on my prpmc800 card (and my 2600
card as well)

1. The 2600 does its thing up to the
      Uncompressing Linux...done.
      Now booting the kernel
    point, then it changes the console speed to some (yet) undetermined
value, how
    do I change that?

2. The prpmc800 is just quiet (and unresponsive) after
      Network Boot File load in progress... To abort hit <BREAK>

      Bytes Received =&694852, Bytes Loaded =&694852
      Bytes/Second   =&694852, Elapsed Time =1 Second(s)

      Residual-Data Located at: $07EBE4FC

Anybody that has a clue (or a working .config to share?)

Regards

Anders Blomdell


------------------------------------------------------------------------------
  Anders Blomdell
  Department of Automatic Control        Email: anders.blomdell@control.lth.
se
  Lund Institute of Technology           Phone: +46 46 222 4625
  Box 118, S-221 00 Lund, Sweden         Fax:   +46 46 138118


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
