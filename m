Subject: Re: AX.25 and libraries
In-Reply-To: <A109131318C4D1119AC20060088DECE327A0C9@MAIL> from Lucinda Schafer at "Feb 24, 2000 04:53:59 pm"
To: lucsch@adaptivemicro.com (Lucinda Schafer)
Date: Sun, 27 Feb 2000 21:42:15 +1100 (EST)
Cc: jra@febo.com, csmall@small.dropbear.id.au, g4klx@g4klx.demon.co.uk,
        linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20000227104215.8E33AC5EA@gonzo.eye-net.com.au>
From: csmall@eye-net.com.au (Craig Small)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lucinda Schafer wrote:
> We want to use the AX.25 driver in an embedded application.
That last sentence does not make sense.  The AX.25 protocol stack, the
ax.25 kiss driver, or the PI driver makes sense.  Same as you don't have
a TCP/IP driver, but you have a NE2000 driver.

> Our Hardware Platform is the BrightStar Engineering ipEngine (with PPC823).
Sounds like some sort of strange powermac.

> The Linux AX.25 Configuration Document specifies the libc6/glibc2.1
> libraries to be used with the 2.2.x kernel. Also, it specifies
> libax25-0.0.7.
Yes, I maintain libax25. This document is talking about the latest
libraries.

> Our BSE board came with Linux Kernel 2.2.13, libc1.99-8xx, AX.25 Release 037
> (which says it requires 2.1.15 kernel).
libc1 ! ax25 037! is that like ax25-037.tgz or something?
You've got some ancient history going there.  2.2.13 will need modern
libraries.

> Do you know the compatibility of the BSE Linux with AX.25? Or maybe give us
> the email address of the person who wrote the Linux AX.25 Configuration
> Document?
I think you've got an address from febo.com.  I believe the generic
ax.25 stuff will work ok under most architectures.  You may have
problems with some device drivers as they either have assembler or do
bit banging.

  - Craig

--
Craig Small VK2XLZ, PGP: AD 8D D8 63 6E BF C3 C7  47 41 B1 A2 1F 46 EC 90
Eye-Net Consulting http://www.eye-net.com.au/     <csmall@eye-net.com.au>
MIEEE <csmall@ieee.org>              Debian developer <csmall@debian.org>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
