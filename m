Subject: Re: What is embedded linux ?
To: pkpathak@dnrc.bell-labs.com (Pravin Pathak)
Date: Thu, 17 Aug 2000 10:29:20 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (linuxppc-embedded@lists.linuxppc.org)
In-Reply-To: <399B0FCD.A6E0A6BE@dnrc.bell-labs.com> from "Pravin Pathak" at Aug 16, 2000 06:03:57 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000817002920.F3DA4132@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pravin Pathak writes:
> I have a silly question. How does embedded linux works without disk
> support ?   I mean from where it loads shell and other application task
> images without any file system support?

It's not a silly question really.  The answer is that they're loaded from a
filesystem as normal, but the filesystem resides on some non-disk media.  Of
course it depends on your application; some embedded systems have a disk, but
many don't. For more info, see the section in the HOWTO at:
    http://members.xoom.com/greyhams/linux/PowerPC-Embedded-HOWTO-12.html

> For VxWOrks/pSOS have a single object file.

And the academics used to criticise the Linux kernel for being monolithic! :-).

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
