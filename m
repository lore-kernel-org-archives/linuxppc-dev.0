Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlQtD3VcqzDrKN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 01:21:52 +1100 (AEDT)
Subject: Linux 4.16: Reported regressions as of Monday, 2018-02-19 (Was: Linux
 4.16-rc2)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
References: <CA+55aFwDnBq9V6TVbc82DzVYpf-ELF7UcYzHuY0ei1Xjnob+0A@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <8af706ec-e1a8-fe16-e11b-6422ac845239@leemhuis.info>
Date: Mon, 19 Feb 2018 14:58:43 +0100
MIME-Version: 1.0
In-Reply-To: <CA+55aFwDnBq9V6TVbc82DzVYpf-ELF7UcYzHuY0ei1Xjnob+0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi! Find below my first regression report for Linux 4.16. It lists 2
regressions I'm currently aware of.

Are you aware of any other regressions? Then please let me know by mail
(a simple bounce or forward to the email address is enough!).

For details see http://bit.ly/lnxregtrackid And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

P.S.: Sorry, I didn't find spare time to work on regression reporting
and related issues during the 4.15 cycle. I also have a huge todo list
after the regression tracking discussion during maintainer and kernel
summit last fall. I will try to work on that that sooner or later; that
in the end will change nearly all the aspects of regression tracking is
done currently. But that will take some time (which I struggle to find
currently :-/ ) to realize, so for this cycle  I'm continuing to do
regression reports like I used to do them.

== Current regressions ==

Debian kernel package tool make-kpkg stalls indefinitely during kernel
build due to commit "kconfig: remove check_stdin()"
Status: stalled after some discussions
Note: Shouldn't be a problem to back this one out either if it turns out
to cause massive amounts of pain in practice I guess, even if it's the
Debian tools doing something weird.
Reported: 2018-02-12
https://marc.info/?l=linux-kernel&m=151846414807219
Cause: d2a04648a5dbc3d1d043b35257364f0197d4d868
Linux-Regression-ID: 2fd778

DM Regression: read() returns data when it shouldn't
Status: Developers are looking into it
Reported: 2018-02-14
https://marc.info/?l=linux-kernel&m=151861337518109&w=2
Cause: 18a25da84354c6bb655320de6072c00eda6eb602
Linux-Regression-ID: 9e195f
