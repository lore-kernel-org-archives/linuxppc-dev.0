Message-ID: <393D584C.6E4A32D8@execpc.com>
Date: Tue, 06 Jun 2000 15:00:12 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: daenzerm@student.ethz.ch
CC: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Francois Felix Ingrand <felix@ingrand.net>,
        Stephan Leemburg <stephan@jvc.nl>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Pismo battery support (was 'Re: Debian pmud package available')
References: <Pine.LNX.4.10.10006062043470.29453-100000@zirkon.biophys.uni-duesseldorf.de> <393D4D15.7CF12E4E@execpc.com> <393D5429.32BEFB20@relog.ch>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel D舅zer wrote:
> Is reported as 12 on my Pismo.

hmm..  Any handy way to tell the difference between the iBook's single and the
Pismo's dual battery capacities?

> The gkrellm plugin (v0.9) always shows an empty battery and 0:00 rest time.

I think at that time, I hadn't thought about error handling.  Those are the
default values, and at the time of v0.9, I had never heard of keylargo.

Its been updated to 0.12 recently.  It handles id 12 the same as a G3 series,
but assumes it only has the left battery (lone iBook battery).  Maybe I should
make it the same as a g3 series.  Later today, I'll see about updating that.  in
the meantime, if you have the time, try the newer version.  Since I assumed 12
has only one battery, it should only show the left battery on a pismo.  you
could edit the sys_pmu.nbattery=1 line to =2 in the KEYLARGO section in
gkrellm-pmu.c:95, and that should fix that.

http://www.execpc.com/~jpgarcia/

Thanks for your help.  It is much appreceated.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

An error occurred while booting.  Please try again.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
