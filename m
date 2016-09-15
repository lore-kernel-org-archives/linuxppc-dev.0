Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZYSc2xStzDsXL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 19:45:52 +1000 (AEST)
Date: Thu, 15 Sep 2016 11:37:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Linux 4.8: Reported regressions as of Sunday, 2016-08-28
Message-ID: <20160915093756.GB13132@amd>
References: <3b3d733e-f193-b039-6113-6c0e5b44c4e7@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3b3d733e-f193-b039-6113-6c0e5b44c4e7@leemhuis.info>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

> Hi! Here is my second regression report for Linux 4.8. It lists 11
> regressions. 5 of them are new; 5 mentioned in the last report two 
> weeks ago got fixed.
> 
> FWIW: A small detail: I did not include "Regression - SATA disks behind 
> USB ones on v4.8-rc1, breaking boot. [Re: Who reordered my disks]" 
> (http://www.spinics.net/lists/linux-usb/msg144871.html ) in below list 
> report. The discussion mentions that device names like /dev/sd? are not 
> considered stable as they might change depending on various factors -- 
> like the order in which modules are loaded or other timing issues (like 
> in this case). That is how it is afaik (even if it's not well known), 
> and that's why I didn't include the issue; let me know if you think it 
> should be on the list.
> 
> OTOH I included "Commit cb4f71c429 deliberately changes order of 
> network interfaces" (http://www.spinics.net/lists/kernel/msg2325600.html )
> for now, as I think traditional network interface names (eth0, eth1, ...)
> might be considered stable -- but I'm not sure, that's why I raise it
> here.
> 
> Anyway, you know the drill: Are you aware of any other regressions?
> Then please let me know. And tell me if there is anything in the
> report that shouldn't be there.
> 
> Ciao, Thorsten
> 
> P.S.: Thanks to all those that Aaro Koskinen, Hans de Goede, Pavel 
> Machek for CCing me when reporting regressions. Much appreciated! Ohh, 
> and thx to all those that replied when I asked them for status updates
> when things look stuck.

Hmm, and there's one more apparently. See

Date: Tue, 13 Sep 2016 22:38:45 +0200
From: Martin Steigerwald <martin@lichtvoll.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, daniel.vetter@intel.com,
        jani.nikula@linux.intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, "Rafael J. Wysocki"
        <rjw@rjwysocki.net>
Subject: Re: 4.8-rc1: it is now common that machine needs re-run of xrandr
        after resume
User-Agent: KMail/5.2.3 (Linux/4.8.0-rc6-tp520-btrfstrim+; KDE/5.25.0; x86_64;  
        ; )

I'm glad I'm not the only one seeing it, but I don't have idea how to
actually debug it.

Thanks and best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
