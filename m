Date: Fri, 21 Jun 2002 10:17:14 -0500
From: Stephen Cameron <steve.cameron@hp.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Anyone used libopt?
Message-ID: <20020621101714.A1468@zuul.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone used this libopt tool?
http://libraryopt.sourceforge.net/

It is supposed to be able to rebuild libraries
to contain only the objects that are actually used
by the programs in your filesystem.

There are some "build" scripts it needs per
library, and an example for glibc is given:
http://libraryopt.sourceforge.net/buildlibc

Are there other build scripts for other libraries
floating around?  The idea of writing my own build
scripts, considering how much of the example script
I actually grok, is daunting.

Any pointers to more explanatory material would be
appreciated.

Thanks.

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
