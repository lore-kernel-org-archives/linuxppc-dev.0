Message-ID: <385EE46B.1D97C2D2@ctam.com.au>
Date: Tue, 21 Dec 1999 13:22:37 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: linux-embedded <linux-embedded@waste.org>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: linux-embedded: which shell, termcap or ncurses ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I am trying to get a powerpc embedded system up and running.  I have
compiled the kernel and can mount a root filesystem using initrd or
nfs.  I now need to get a shell running so I can call shell scripts to
setup the IP addresses etc via ifconfig (is there any other way ?).

I got the latest version of bash(2.0.3) and ncurses(5.0).  Bash requires
termcap but apparently termcap is obsolete and is replaced by ncurses.

I had some trouble getting ncurses to cross-compile but I manged to hack
around with configure, make and the source code and eventually get it to
compile and install.  Bash is proving more difficult.

Does anyone have any recommendations for a good shell and termcap that
cross-compiles without too much effort ?  If so, where can I get them
and are they maintained ?

Has anyone cross-compiled a recent version of bash and ncurses ?  Are
they huge ?  Will they fit on a 4MB initrd image ?

Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
