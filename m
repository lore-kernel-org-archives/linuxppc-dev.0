Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6fxN1xGNzDvK0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 14:29:44 +1100 (AEDT)
Message-ID: <1477884575.32311.67.camel@kernel.crashing.org>
Subject: Re: Linux 4.9: Reported regressions as of Sunday, 2016-10-30
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Date: Sun, 30 Oct 2016 21:29:35 -0600
In-Reply-To: <0eb29167-7908-e049-6927-d9c6b093970d@leemhuis.info>
References: <0eb29167-7908-e049-6927-d9c6b093970d@leemhuis.info>
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

On Sun, 2016-10-30 at 14:20 +0100, Thorsten Leemhuis wrote:
> 
> Desc: PPC32: fails to boot on my PowerBook G4 Aluminum; bisected to
> commit 05fd007e4629
> Repo: 2016-10-20 https://www.mail-archive.com/linux-kernel@vger.kerne
> l.org/msg1253391.html
> Stat: 2016-10-22 https://www.mail-archive.com/linux-kernel@vger.kerne
> l.org/msg1255516.html https://www.linux-mips.org/archives/linux-mips/
> 2016-10/msg00176.html https://lkml.org/lkml/2016/10/18/142
> Note: Larry made a hack that works for him.

This breaks framebuffer console on ppc64 I've been told as well, I
heard...

I'm at KS now, hard to get you more details, but there's something
fishy here either with the commit or with something we do on ppc with
fbdev that this commit breaks.

Cheers,
Ben.
