Date: Wed, 1 Oct 2003 15:32:09 -0400
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Where to Put Ethernet MAC Addresses?
Message-ID: <20031001153209.D688@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In boards where there is ethernet but no manufacturered in MAC address
in the ethernet hardware, where does one get it?  Does this become a
userland problem to be handled in init scripts?  It seems that
ethernet initialization could also set the "manufacturer" MAC address,
and it might be stored in flash next to the Linux image, or in some
extra SPD bits, etc.

What are the various right ways to do this?


Thanks,


-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
