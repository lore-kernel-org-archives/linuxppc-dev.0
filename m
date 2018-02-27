Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrGV05SQ3zF0lb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 22:21:05 +1100 (AEDT)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>,
 x86 <x86@kernel.org>, William Grant <william.grant@canonical.com>,
 Woody Suwalski <terraluna977@gmail.com>
Subject: Re: Linux 4.16: Reported regressions as of Monday,
 2018-02-26 (Was: Linux 4.16-rc3)
Date: Tue, 27 Feb 2018 12:21:48 +0100
Message-ID: <1585962.fYXxTULH6v@aspire.rjw.lan>
In-Reply-To: <2cf45d87-066c-7368-3fbd-20675f2d74ae@leemhuis.info>
References: <CA+55aFxk5KBxL9DvRtBivP3hKT-aOAzvSA_B47L1+y0P2GLe_A@mail.gmail.com>
 <2cf45d87-066c-7368-3fbd-20675f2d74ae@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, February 26, 2018 11:25:09 AM CET Thorsten Leemhuis wrote:
> On 26.02.2018 04:05, Linus Torvalds wrote:
> > We're on the normal schedule for 4.16 and everything still looks very regular.
> 
> Hi! Find below my second regression report for Linux 4.16. It lists 8
> regressions I'm currently aware of.
> 
> To anyone reading this: Are you aware of any other regressions that got
> introduced this development cycle? Then please let me know by mail (a
> simple bounce or forward to the email address is enough!).
> 
> For details see http://bit.ly/lnxregtrackid And please tell me if there
> is anything in the report that shouldn't be there.

Please add https://bugzilla.kernel.org/show_bug.cgi?id=198763

It has a bisect result and seems to be readily reproducible.

No response from the author of the problematic commit so far.

Thanks,
Rafael
