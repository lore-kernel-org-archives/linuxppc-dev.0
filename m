Date: Wed, 7 May 2003 09:14:43 -0400
From: Callebaut Benoit <callebaut@mailandnews.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: What kind of Linux address must I use to set the SAR reg. of the DMA ctrl ?
Message-ID: <3EBD1B7E@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks a lot Matt,

now the Memory to memory transfer works but I don't see any data on the PCI
side althought the status register of the DMA controller report no error.
I read that I must use untranslated PCI address if the outbound translation
windows are not enabled (this is my case).
So I suppose I must take the address coming from the PCI detection and the
ioremap following it (those appearing in the log like "kernel :PCI:00:12.0:
Resource 1:bf000000-bf7FFFFF") and not the translated one.
I tried so but only 0XFFFFFFFF appears in the memory of the PCI device.
Is it possible that the snooping or caching issue be the problem ?

Regards,

Benoit Callebaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
