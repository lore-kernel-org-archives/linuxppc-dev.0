Date: Fri, 15 Feb 2002 09:17:33 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Larry McVoy <lm@bitmover.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.5 development
Message-ID: <20020215091733.E8353@work.bitmover.com>
References: <15468.64269.8252.644104@argo.ozlabs.ibm.com> <20020215085812.Z8353@work.bitmover.com> <3C6D3ED2.19A93322@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C6D3ED2.19A93322@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Feb 15, 2002 at 12:01:06PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


To export comments, you need this command (we're add it to the docs): I got it
wrong the first time:

bk changes -r+ -vnd'### Comments for :GFILE:\n$each(:C:){(:C:)\n}'

Yup, those dspecs (printf like things) are pretty weird, but well worth
understanding.  You can do some amazing things with them.  BK/Web is
essentially a pile of big dspecs handed to bk prs.

A very useful thing is this:

bk set -d -rbk-2.1.3 -r+ | bk changes -

which says "list all the changes after bk-2.1.3 and send that list to
changes to get a changes style listing".  This is what Linus (and everyone
else) uses to generate release notes.
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
