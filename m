Message-ID: <392B854B.F9AC566E@execpc.com>
Date: Wed, 24 May 2000 02:31:23 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Stephan Leemburg <stephan@jvc.nl>
CC: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Sergio Brandano <sb@dcs.qmw.ac.uk>, linuxppc-dev@lists.linuxppc.org,
        debian-powerpc@lists.debian.org
Subject: Re: PMUD vs APM
References: <B5514D3F.E6B3%stephan@jvc.nl>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Stephan Leemburg wrote:
> Yes, it's activated with the -a flag (see pmud --help for details). I need
> to modify the manuals and /etc/power/apm. You must have a modified apm
> program to use it however, as the 'standard' apm programs all read from
> /proc/apm and this path is usually compile time determined...

I also found this kind of annoying.  And as far as I can tell, APM doesn't show
everything.  This is why I wrote a plugin for GKrellM that, using PMUD, displays
battery status in a window.  Its almost as good as Batmon, but smaller.  I know
this works on Wallstreet, PDQ, and Lombard, and have untested code for other
systems.  If you already used GKrellM, this is something to try.  And I still
need testers for systems I don't have access to.

Are there any other PMU-savvy monitors out there?

Thanks.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
