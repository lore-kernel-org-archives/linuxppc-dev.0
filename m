Subject: Re: 4MB DRAM is enough for linux kernel 2.2.13
To: jari.nguyen@serialsystem.com.sg
Date: Wed, 20 Sep 2000 14:08:39 +1100 (EST)
Cc: dan@mvista.com (Dan Malek),
        pmpatel@trinetcommunication.com (Prashant Patel),
        linuxppc-embedded@lists.linuxppc.org, thanh_nguyen@smartstors.com
In-Reply-To: <39C820B5.D34ADBE1@serialsystem.com.sg> from "Jari" at Sep 20, 2000 09:28:05 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000920030839.5BB2BB7@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jari writes:
> Can anybody tell me the minimum size of the linux kernel 2.2.13  that we can
> reduce?   (this kernel doesn't need console, anything else ... just boot and
> run my own program)

It's not so much the kernel you need to worry about, it's the root file system
containing the runtime libraries that take up most of the space.
Nevertheless, I have some kernel minimisation patches available at:
    http://members.nbci.com/greyhams/linux/patches/2.2

> If I want to support only ftp, what is the minimum size of ramdisk ?
> I think if I reduce the code of the kernel and the library libc6, 4MB is OK.

As Dan said, you won't fit a ramdisk in only 4Mb.  You would need to use a
(probably compressed) flash filesystem; others have done it, but is it worth
the hassle given that RAM is cheaper anyway?

You can find more info about this in the HOWTO at:

http://members.nbci.com/_XMCM/greyhams/linux/PowerPC-Embedded-HOWTO-3.html#ss3.2

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
