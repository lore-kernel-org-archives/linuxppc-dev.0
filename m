Return-Path: <pavel@ucw.cz>
Received: from amd.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id 027A2DDE4A
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 23:34:37 +1100 (EST)
Date: Tue, 13 Feb 2007 13:12:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 05/12] power management: no valid states w/o pm_ops + docs
Message-ID: <20070213121249.GJ18101@elf.ucw.cz>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124612.176570000@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070207124612.176570000@sipsolutions.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@ozlabs.org,
	linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

> This patch changes /sys/power/state to not advertise any valid states
> (except for disk if SOFTWARE_SUSPEND is enabled) when no pm_ops have been
> set so userspace can easily discover what states should be available.
> 
> Also, because the pm ops in powermac are obviously not using them as
> intended, I added documentation for it in kernel-doc format.
> 
> Reordering the fields in struct pm_ops not only makes the output of
> kernel-doc make more sense but also removes a hole from the structure on
> 64-bit platforms.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-pm@lists.osdl.org
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Pavel Macheck <pavel@ucw.cz>

Looks okay to me.
										Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
