Message-ID: <3B7AE05D.1090906@mvista.com>
Date: Wed, 15 Aug 2001 13:49:33 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: clark@esteem.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Loading Hard Hat 2.0
References: <5.0.0.25.1.20010815131839.0208f070@pop.esteem.com> <20010815134348.N15482@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

 > On Wed, Aug 15, 2001 at 01:33:56PM -0700, clark@esteem.com wrote:
 >
 >
 >> 	Has anybody loaded Hard Hat 2.0 Linux Journeyman edition on Red
 >> Hat 7.1 yet? I know its been asked before, but I was wondering if
 >>  the answer has changed from no.
 >
 >
 > RedHat 7.1 is not a supported target.  See below.
 >
 >
 >> 	Is there an easy way to install Hard Hat 2.0 without removing my
 >> 1.0 	install?
 >
 >
 > Normally, yes.  But, I _think_ the main reason RedHat 7.1 isn't
 > supported is that the version of RPM shipped by default does NOT
 > support relocation, so you can't install HHL 2.0 into another
 > subdir and have 1.x and 2.0 co-exist.
 >

If relocation is not a big deal, you can either fake out our installer
or install by hand (use rpm).

To fake out the installer I think you just change /etc/redhat-release to
7.0 instead 7.1.  Of course, change it back once the install finishes:)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
