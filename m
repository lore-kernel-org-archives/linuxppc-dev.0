Message-ID: <393D5429.32BEFB20@relog.ch>
Date: Tue, 06 Jun 2000 21:42:33 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Joseph Garcia <jpgarcia@execpc.com>
CC: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Francois Felix Ingrand <felix@ingrand.net>,
        Stephan Leemburg <stephan@jvc.nl>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Debian pmud package available
References: <Pine.LNX.4.10.10006062043470.29453-100000@zirkon.biophys.uni-duesseldorf.de> <393D4D15.7CF12E4E@execpc.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joseph Garcia wrote:

> What PMU_VERSION id does the Pismo have?  the plugin is written to support
> up to 12 (keylargo/iBook).

Is reported as 12 on my Pismo.

> My page lists Pismo as unsupported because I know nothing about how PMUD
> handles it.  Looking at the code, it appears as if it is just another smart
> battery.  But there is no evidence to a PMU_VERSION relating to it.

The gkrellm plugin (v0.9) always shows an empty battery and 0:00 rest time.

> Does Batmon display for Pismo systems?  I could update it to support Pismo
> ASAP if I get some input.

Francois told me it does; haven't tested it myself.


Michel


--
Been there, done that, can't remember why...
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
