Message-ID: <3B3EB070.B8AA5EDE@mvista.com>
Date: Sun, 01 Jul 2001 01:09:04 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Paul White <pwhite@networkrobots.com>
Cc: jtm@smoothsmoothie.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: (allocating non-cachable memory) (or More on the i82596)
References: <20010626160844.A20988@shamus.smoothsmoothie.com> <200106291744.f5THia810339@stimpy.networkrobots.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul White wrote:

> Is there something I'm missing here?

Yeah...you can run 'nobats' as a start option and get the memory
mapped as pages (or fix your system so cache coherency works :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
