From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15331.17574.209385.901060@cargo.ozlabs.ibm.com>
Date: Sat, 3 Nov 2001 12:13:10 +1100 (EST)
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods
In-Reply-To: <20011012111320.B10280@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011012111320.B10280@cpe-24-221-152-185.az.sprintbbd.net>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini writes:

> On Fri, Oct 12, 2001 at 05:32:34PM +1000, Paul Mackerras wrote:
>
> > I would like to make a complete list of the methods people use to boot
> > the PPC/Linux kernel on different platforms.  As a start, here is what
> > I can think of off the top of my head:
>
> All of the 7xx/74xx/8240 boards in _devel boot via zImage.<board> from
> network/disk/flash, depending.

Would you mind enumerating them for me?  I would like to have a list
of the various embedded boards we support in _devel together with the
value of <board> in the zImage filename, plus what software is used to
load that into memory.

Thanks,
Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
