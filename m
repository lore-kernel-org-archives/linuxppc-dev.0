Date: Wed, 12 Jun 2002 03:51:10 -0700
From: Matt Porter <porter@cox.net>
To: Paul Mackerras <paulus@samba.org>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony bootloader
Message-ID: <20020612035110.A29183@home.com>
References: <20020611234337.46834.qmail@web11503.mail.yahoo.com> <20020611195130.C28767@home.com> <15622.55222.41836.183547@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15622.55222.41836.183547@argo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Jun 12, 2002 at 03:10:14PM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 12, 2002 at 03:10:14PM +1000, Paul Mackerras wrote:
> Matt Porter writes:
>
> > Read Understanding Linux, Linux Device Drivers, and the
> > documentation in Documentation/ directory.  ioremap64()
> > is a version of ioremap() for >32-bit physical address
> > systems (440, 745x).
>
> Incidentally, I don't think we should have ioremap64 or
> ioremap_native, instead ioremap should just take a phys_addr_t.  It
> will have to do some handling of truncated addresses from pci drivers

It already does that work.

> but that should be manageable and the interface will be much more
> uniform if we use ioremap everywhere instead of using ioremap,
> ioremap64 and ioremap_native in different places.

Yes, I agree.  At the beginning of this, I was thinking that a
different ioremap prototype was going to get us into to compiler
trouble.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
