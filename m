Date: Fri, 25 Jul 2003 11:30:26 -0400
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: IO, ANSI vs GCC structs
Message-ID: <20030725113026.E29161@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The PPC arch likes to access physical devices with C structures that
correspond to a memory map of device registers.  But a colleague says
that structure layout is not guaranteed.  In fact, he cited two
instances when he got burned by assuming he could predict structure
layout.  But neither of those examples were with GCC.

Does GCC make guarantees beyond what ANSI requires?  Is there some
subtle detail that forces struct layout ("volatile" in the definition
perhaps)?


Thanks,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
