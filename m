Message-ID: <37DF0C38.34352830@ctam.com.au>
Date: Wed, 15 Sep 1999 13:02:17 +1000
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: Dan Malek <dmalek@jlc.net>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx updates
References: <37DF00DD.A0806F12@jlc.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> OK.  I just posted all of the outstanding 8xx updates to the
> CVS tree.  Read the web page for more info.

:)


> I will probably make mbx_defconfig a generic m8xx_defconfig that will
> build on all boards.  You can then selectively add features you
> know your board supports.  I just haven't found the lowest
> common denominator yet.

Sounds ok.

The other thing that needs to be done is the help documentation.  I tend to
use "make xconfig" when configuring my kernel.  This gives me the ability to
load and store configuration files and then only change the bits I need to
without going through the entire configuration processes.  The other reason is
that it has a help button for all the configuration options.  I believe "make
menuconfig" also has help features.  There are so many options that it is hard
to remember what all of them do (unless you have read the docs a million
times).  The 2.2.x and 2.3.x series from kernel mirrors have the help docs but
none of the embedded archives (embedded-2.2.5 and mpc8xx-2.3.10) seem to have
them.  I think its just a matter of copying the help files to the
Documentation directory.

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
