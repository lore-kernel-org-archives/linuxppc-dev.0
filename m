Date: Sun, 28 Jul 2002 07:40:09 -0700
From: Larry McVoy <lm@bitmover.com>
To: Eugene Surovegin <ebs@innocent.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bitkeeper changeset numbering glitch in 2_4_devel tree
Message-ID: <20020728074009.D9612@work.bitmover.com>
References: <5.1.0.14.2.20020727122936.02ababf0@pop.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20020727122936.02ababf0@pop.prodigy.net>; from ebs@innocent.com on Sat, Jul 27, 2002 at 12:48:32PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> What today shows up as changeset 1.1155 may in future become something like
> 1.1088.1.30. I'm sure that Bitkeeper uses other way of identification
> internally but it's not user accessible.

The internal names are called keys or inodes and you get at them with

	bk prs -hr<whatever> -nd:KEY: <filename>

In general, anywhere you can use a revision, you may use a key instead.
Nt in BK/web yet though.
--
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
