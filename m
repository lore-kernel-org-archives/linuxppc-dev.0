Date: Tue, 13 May 2003 20:47:43 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Wolfgang Denk <wd@denx.de>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: set_rtc_time() cleanup / normalization
Message-ID: <20030513204743.A31841@home.com>
References: <Your <5.1.0.14.2.20030513161846.03805338@mail.ebshome.net> <20030514000820.B3397C6092@atlas.denx.de> <5.1.0.14.2.20030513171616.037f6800@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20030513171616.037f6800@mail.ebshome.net>; from ebs@ebshome.net on Tue, May 13, 2003 at 05:30:13PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, May 13, 2003 at 05:30:13PM -0700, Eugene Surovegin wrote:
> >The main reason to remove it is thatit's broken (i. e. causes  kernel
> >crashes) on many hardware configurations.
>
> Well, properly implemented set_rtc_time will not cause kernel crashes.
> I doesn't crash on our hardware. Guess why?

Well, I didn't want to "me too" as an opponent of doing this in the
kernel but I guess I need to.  This type of thing doesn't *need* to
be in the kernel because it can be implemented in userspace.

<snip>

> >and you just removed the only argument to put
> >it into the timer interrupt at all.
>
> Well, I don't see such placement as an optimization, just as some place
> from where it can be done easily without requiring cron, hwclock or other
> usermode stuff.

If cron and hwclock are too heavyweight for your fs then this is
screaming for a simple busybox solution.  I haven't looked at
busybox in a while, most of it might even be there already in a
slimmed down form factor.

Regards,
--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
