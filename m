Date: Sun, 21 Oct 2001 19:56:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dave Ray <g4tinker@yahoo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: idebus=133 ?
Message-ID: <20011021195658.D1419@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011021224211.561.qmail@web13105.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011021224211.561.qmail@web13105.mail.yahoo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Oct 21, 2001 at 03:42:11PM -0700, Dave Ray wrote:

> It's my understanding the Mac G4 towers run at a bus
> speed of 133 MHz. However the kernel argument for
> idebus=xx apparently only allows values up to 66. Is
> this intentional?

idebus != 'bus'.  The 133 referrs to the speed the memory and cpu can
talk at.  Your idebus setting shouldn't change from the default.
>From Documentation/ide.txt:
"idebus=xx"            : inform IDE driver of VESA/PCI bus speed in MHz,
                                where "xx" is between 20 and 66 inclusive,
                                used when tuning chipset PIO modes.
                                For PCI bus, 25 is correct for a P75 system,
                                30 is correct for P90,P120,P180 systems,
                                and 33 is used for P100,P133,P166 systems.
                                If in doubt, use idebus=33 for PCI.
                                As for VLB, it is safest to not specify it.
                                Bigger values are safer than smaller ones.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
