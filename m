Date: Tue, 18 Jul 2000 23:13:20 +0200 (MET DST)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Joseph Garcia <jpgarcia@execpc.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: switching consoles
In-Reply-To: <3974C0DD.7097988A@execpc.com>
Message-ID: <Pine.SOL.3.95.1000718225607.3933D-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 18 Jul 2000, Joseph Garcia wrote:
>
> After writing this, i thought.. hmm.  isn't that a lot more a 'trackpad' tap
> like thing, rather than a OF thing?  If it is stored in nvram, its probably just
> read by a MacOS extention, which then sets the hardware.  so its probably not as
> straight forward as I thought/made it out to seem.  My bad.
>
> anyone know how this is actually done?  I think a Linux app would be the
> ultimate solution.  trackpad is a required tool for pb users IMO, and this could
> become another of those tools.
>
Don't know, to be honest, but the reason I came to think about this was,
that when I tested a couple of 2.2.17pre10 kernels the other week, on
a crash the boot vars were always set back to defaults, i.e. boot-device
was 'hd:,\\:tbxi', boot-command was 'mac-boot', and the F[1-12] keys were
also back to the default setting.
However, this might also be a side effect of writing evil things to the PMU,
because the crashes were all related to not being able to power on the
backlight and wake up from sleep mode. Does the PMU handle the ADB stuff as
well (think I heard so, but not positive)?

Greetings,
							Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
