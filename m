From: Subodh Nijsure <subodh@best.com>
Message-Id: <200102151605.IAA16934@shell9.ba.best.com>
Subject: How does one get physical address for iorempped window?
To: linuxppc-embedded@lists.linuxppc.org
Date: Thu, 15 Feb 2001 08:05:07 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[ Perhaps not directly linux-ppc question ]

I am trying to get jffs working on my board and in trying to debug this
I need to know this.  The jffs driver requires that I map the flash address
space usinng ioremap_nocache or ioremap, when debugging I need to see exactly
which addresses its writing the CFI query commands.

My question is --

If I map memory window using ioremap_nocache() if I use virt_to_phys()
should one get back the actual physical address? If virt_to_phys is not
the correct function to use, how do I get  exact physical address?

Thanks.

/Subodh Nijsure

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
