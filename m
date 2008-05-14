Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D5E34DDED7
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 22:25:48 +1000 (EST)
Date: Wed, 14 May 2008 16:25:44 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/6] [WATCHDOG] mpc83xx_wdt: rename to mpc8xxx_wdt
Message-ID: <20080514122544.GA8746@polina.dev.rtsoft.ru>
References: <20080513141411.GA8981@polina.dev.rtsoft.ru>
	<20080513141459.GC15717@polina.dev.rtsoft.ru>
	<20080514114523.ae20b0da.sfr@canb.auug.org.au>
	<20080514114805.61e1d50f.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080514114805.61e1d50f.sfr@canb.auug.org.au>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wim Van Sebroeck <wim@iguana.be>, Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 14, 2008 at 11:48:05AM +1000, Stephen Rothwell wrote:
> Hi Anton,
> 
> On Wed, 14 May 2008 11:45:23 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Doing this status with "git diff -M --stat" would show us if the file was
> > just renamed or if there were some changes as well ...
> 
> Not that I don't trust you, just for future reference.

I use git-format-patch. And -M option would generate the whole
patch in the "git patch format", which you can not apply with patch(1)
(I also recalling that there was someone protesting wrt sending the
patches in the git patch format, since not everybody use git).

Though, you can still check me if you want to, git generates useful
headers in the patch itself:

diff --git a/drivers/watchdog/mpc83xx_wdt.c b/drivers/watchdog/mpc83xx_wdt.c
deleted file mode 100644
index 3534ae0..0000000
....
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
new file mode 100644
index 0000000..3534ae0

The index stuff are hashes. They match. ;-)

But sure, it would be great if git-format-patch could generate
diffstat in the git format and leave the patch itself patch(1)-compatible.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
