From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15622.55222.41836.183547@argo.ozlabs.ibm.com>
Date: Wed, 12 Jun 2002 15:10:14 +1000 (EST)
To: Matt Porter <porter@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony bootloader
In-Reply-To: <20020611195130.C28767@home.com>
References: <20020611234337.46834.qmail@web11503.mail.yahoo.com>
	<20020611195130.C28767@home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter writes:

> Read Understanding Linux, Linux Device Drivers, and the
> documentation in Documentation/ directory.  ioremap64()
> is a version of ioremap() for >32-bit physical address
> systems (440, 745x).

Incidentally, I don't think we should have ioremap64 or
ioremap_native, instead ioremap should just take a phys_addr_t.  It
will have to do some handling of truncated addresses from pci drivers
but that should be manageable and the interface will be much more
uniform if we use ioremap everywhere instead of using ioremap,
ioremap64 and ioremap_native in different places.

Paul.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
