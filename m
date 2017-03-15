Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjX7R6TgszDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 11:10:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Linux 4.11: Reported regressions as of Tuesday, 20176-03-14
In-Reply-To: <5d399102-c648-7a87-1dff-f8b74c12ceaa@leemhuis.info>
References: <5d399102-c648-7a87-1dff-f8b74c12ceaa@leemhuis.info>
Date: Wed, 15 Mar 2017 11:10:43 +1100
Message-ID: <87d1djv1q4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> Hi! Find below my first regression report for Linux 4.11. It lists 9
> regressions I'm currently aware of.
>
> As always: Are you aware of any other regressions? Then please let me
> know (simply CC regressions@leemhuis.info). And please tell me if there
> is anything in the report that shouldn't be there.
>
> Ciao, Thorsten
>
> P.S.: Sorry, I didn't compile any regression reports for 4.10: I 
> didn't find time due to various reasons (vacation, a cold, regular 
> work, and attending two conferences). Reminder: compiling these reports
> has nothing to do with my paid job and I'm doing it in my spare time
> just because I think someone should do it.
>
> P.P.S: Dear Gmane mainling list archive webinterface, please come
> back soon. I really really miss you. It hurts ever single day.
> Don't you miss me, too? ;-)
>
> == Current regressions ==
>
> Desc: PowerPC crashes on boot, bisected to commit 5657933dbb6e
> Repo: 2017-03-02 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1343553.html
> Stat: 2017-03-09 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1349568.html
> Note: patch hopefully heading mainline

Now fixed in Linus' tree by commit 46f401c4297a.

cheers
