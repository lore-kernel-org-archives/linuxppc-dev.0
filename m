Message-ID: <378606DD.46E44252@mitre.org>
Date: Fri, 09 Jul 1999 10:27:41 -0400
From: Charles Lepple <clepple@mitre.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: syntax error in include/asm-ppc/page.h
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In the CVS repository (as of this morning; file revision 1.19), there is
a "while (0)" missing from include/asm-ppc/page.h (line 26; should look
like line 21)

This problem only appears to manifest itself when xmon support is
enabled. It's trivial to fix, but I figured someone with CVS write
access might want to fix it in the repository.

--Charles Lepple
clepple@mitre.org

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
