Date: Tue, 6 Apr 2004 14:14:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Tolunay Orkun <listmember@orkun.us>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question on RTC options (CONFIG_RTC, CONFIG_GEN_RTC, CONFIG_PPC_RTC)
Message-ID: <20040406211439.GD31152@smtp.west.cox.net>
References: <15133.216.110.51.8.1081278001.squirrel@www.orkun.us> <20040406200057.GB31152@smtp.west.cox.net> <19625.216.110.51.8.1081285199.squirrel@www.orkun.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19625.216.110.51.8.1081285199.squirrel@www.orkun.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 06, 2004 at 03:59:59PM -0500, Tolunay Orkun wrote:

> >> CONFIG_RTC (PC Architecture?)
> >> CONFIG_GEN_RTC
> >> CONFIG_PPC_RTC
> >>
> >> I also saw references to CONFIG_GEN_RTC_X with Google searches...
> >>
> >> I appreciate if someone explain me when to use each of these kernel
> >> config
> >> options?
> >
> > In the context of 2.4 or 2.6?
>
> 2.4

CONFIG_RTC is the "pc style" rtc driver, which works on a number of
arches, so long as they have a rtc chip found in PCs, and it can be
talked to as such.
GEN_RTC is a generic RTC driver, which offers hooks to the architectures
to do the hw-specific portions.  This _could_ be made to work with RTCs
over I2C, but at this time does not.
PPC_RTC is like the above, except it calls the PPC hooks directly, and
is obsolete (and gone in 2.6).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
