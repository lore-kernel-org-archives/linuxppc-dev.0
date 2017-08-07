Return-Path: <machek@atrey.karlin.mff.cuni.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQzK42ypWzDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 23:44:08 +1000 (AEST)
Date: Mon, 7 Aug 2017 15:38:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Linux 4.13: Reported regressions as of Sunday, 2017-08-06
Message-ID: <20170807133815.GA18965@atrey.karlin.mff.cuni.cz>
References: <a6b015b1-a4da-c56b-89e4-629c873af4d0@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a6b015b1-a4da-c56b-89e4-629c873af4d0@leemhuis.info>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

> Hi! Find below my second regression report for Linux 4.13. It lists 10
> regressions I'm currently aware of (albeit in one case it's not entirely
> clear yet if it's a regression in 4.13). One regression got fixed since
> last weeks report. You can also find the report at
> http://bit.ly/lnxregrep413 where I try to update it every now and then.
> 
> As always: Are you aware of any other regressions? Then please let me
> know. For details see http://bit.ly/lnxregtrackid And please tell me if
> there is anything in the report that shouldn't be there.

There's compile-time regression in et8ek8, with patch available.

On 2017-06-08 02:01, Arnd Bergmann wrote:
> This one got applied twice, causing a build error with clang:
>
> drivers/media/i2c/et8ek8/et8ek8_driver.c:1499:1: error: redefinition
> of '__mod_of__et8ek8_of_table_device_table'
>
> Fixes: 9ae05fd1e791 ("[media] et8ek8: Export OF device ID as module
aliases")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
