Message-ID: <393D4D15.7CF12E4E@execpc.com>
Date: Tue, 06 Jun 2000 14:12:21 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
CC: Michel Ddnzer <daenzerm@student.ethz.ch>,
        Francois
	Felix Ingrand <felix@ingrand.net>,
        Stephan Leemburg <stephan@jvc.nl>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Debian pmud package available
References: <Pine.LNX.4.10.10006062043470.29453-100000@zirkon.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
> > How? At least the gkrellm pmud plugin doesn't show the charge level here.
>
> You need the -a flag for pmud to switch on apm support, plus the plugin
> needs to read from /etc/power/apm instead from /proc somewhere.

the GKrellM PMU plugin uses PMUD directly rather than using the APM-frontend.
What PMU_VERSION id does the Pismo have?  the plugin is written to support up to
12 (keylargo/iBook).  My page lists Pismo as unsupported because I know nothing
about how PMUD handles it.  Looking at the code, it appears as if it is just
another smart battery.  But there is no evidence to a PMU_VERSION relating to
it.  Does Batmon display for Pismo systems?  I could update it to support Pismo
ASAP if I get some input.

For plugins like this, should the pmud.h be put in a public location, like
/usr/include/pmud?  It has useful info, like PMU_VERSION and related strings,
which dont need to be in several places.  also makes a nice dependancy to make
sure PMUD is installed.

Thanks.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

An error occurred while booting.  Please try again.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
