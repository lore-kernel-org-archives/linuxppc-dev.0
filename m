Message-ID: <3B7056AA.EAE5CEE1@mvista.com>
Date: Tue, 07 Aug 2001 16:59:22 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: How about a few symlinks.....
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


While editing some Makefiles I was wondering what people thought
of using symlinks to processor dependent files instead of nested
ifdefs in Makefiles?

For starters, make arch/ppc/kernel/head.S a symlink to the appropriate
one in that directory, and derive the name to use from one of the
config options.  I thought I would ask before demonstrating the change.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
