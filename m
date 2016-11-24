Return-Path: <pebolle@tiscali.nl>
Received: from lb2-smtp-cloud2.xs4all.net (lb2-smtp-cloud2.xs4all.net
 [194.109.24.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPbkV36wyzDw62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 21:57:03 +1100 (AEDT)
Message-ID: <1479985012.2768.4.camel@tiscali.nl>
Subject: Re: Linux 4.9: Reported regressions as of Sunday, 2016-11-20
From: Paul Bolle <pebolle@tiscali.nl>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 24 Nov 2016 11:56:52 +0100
In-Reply-To: <fde89288-e3bc-356f-8d64-6f9a1cf23c47@leemhuis.info>
References: <fde89288-e3bc-356f-8d64-6f9a1cf23c47@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-11-20 at 16:09 +0100, Thorsten Leemhuis wrote:
> Desc: "build regression: make.cross ARCH=mips fails with ""No rule to make target 'alchemy/devboards/'. """
> Repo: 16-10-30 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1262410.html https://marc.info/?l=linux-kernel&m=147780880425626
> Stat: n/a 
> Note: nothing happened yet; BTW: Should build regressions be on this list at all?

Fixed by commit 818f38c5b7c4 ("MIPS: Fix build of compressed image"). So this
is actually fixed since v4.9-rc4, but I only looked into this again today.

Thanks,


Paul Bolle
