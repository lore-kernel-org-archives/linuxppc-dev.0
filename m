Message-ID: <3C08CFF0.18A1FBC7@wanadoo.fr>
Date: Sat, 01 Dec 2001 13:41:20 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: [PATCH] Minor changes to control/imstt/platinum/valkyrie/atyfb
References: <20011127143058.R13091@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
>
> Hello all.  The following patches make slight changes to the vmode/cmode
> logic on a few fb drivers.  Now everone consistantly only tries to get
> these modes from nvram if CONFIG_NVRAM is defined (otherwise a
> compile-time error on everyone but atyfb).  On imsttfb I made the logic
> only executed on CONFIG_ALL_PPC, and removed USE_NV_MODES (which
> shouldn't be needed now).  However, I have none of this hardware, and I
> remember some of these drivers being very touchy.  So could people with
> this hardware apply the patch and let me know if it works still?

For the valkyriefb driver on my Pmac 6400, I can confirm from a first
short test that it still works. This is with your patch applied to
today's 2.4.17-pre1-ben0 kernel.

I am not testing it very extensively, because this kernel crashes on me
as soon as pppd is started. Yesterday's 2.4.16-ben0 crashed when running
ping. Even on my iBook, the 2.4.16 gave me an "illegal lseek" when
trying to run ping (the 2.4.17-pre1 seems to work OK on the iBook).
Since the 6400 is serving as an adsl router, I prefer to go back to the
stable 2.4.0-pmac kernel from last January.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
