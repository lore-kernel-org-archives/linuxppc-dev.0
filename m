Message-ID: <3A8C0BC4.DB7F6F7A@mvista.com>
Date: Thu, 15 Feb 2001 12:03:00 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Subodh Nijsure <subodh@best.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How does one get physical address for iorempped window?
References: <200102151605.IAA16934@shell9.ba.best.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Subodh Nijsure wrote:

> If I map memory window using ioremap_nocache() if I use virt_to_phys()
> should one get back the actual physical address?

Ummmm....you give ioremap_nocache() a physical address to map, so
you have to know it........Using virt_to_phys() may not give you
the proper physical address, depending upon the platform.  I'm working
on a solution for 2.5 that will work.  Currently, it is wrapped into
a heavier weight virt_to_bus/phys() but that many not be the right
place.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
