From: jlquinn@us.ibm.com
To: Stephane GEORGES <sg@dalim.de>
cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <8525687A.0059AAA1.00@D51MTA03.pok.ibm.com>
Date: Thu, 3 Feb 2000 11:19:38 -0500
Subject: Re: Speed tests - G4-400 and PIII-600
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I realized after sending off my reply that I hadn't bothered to read your
email completely before responding.  For starters, you should try
rebuilding your test program with gcc-2.95.2 or perhaps with a recent
snapshot of the development branch of gcc.  This will at least get you the
latest compiler optimizations available.

How intensive is the computation on the image?  If you are running through
a large image with short computations at each pixel, you may be limited by
memory bandwidth.  Both of those machines have 100Mhz busses, right?  In
this case, you'd be roughly even at the start from a raw hardware viewpoint
and then the fact that x86 tends to receive more optimization work in the
compiler might push it into the lead.

Jerry Quinn
jlquinn@us.ibm.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
