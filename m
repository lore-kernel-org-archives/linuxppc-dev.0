Message-ID: <39AEAC18.7EA022BC@execpc.com>
Date: Thu, 31 Aug 2000 14:03:52 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: daenzerm@student.ethz.ch
CC: Gabriel Paubert <paubert@iram.es>, Dan Malek <dan@netx4.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Tony Mantler <nicoya@apia.dhs.org>,
        Tom Rini <trini@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
References: <Pine.HPX.4.10.10008311808260.15978-100000@gra-ux1.iram.es> <39AE85BD.1B4651BB@relog.ch>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel D舅zer wrote:
> A few days ago, I rsynced linux-pmac-devel and tried 2.4.0-test7(-pre?) . I
> had problems with the network, no TCP connection could be established. Anyone
> seen this?

When I tried 2.4, it takes forever for a name to resolve.  connections seem ok
once they are made.

My system also seems to have a fork problem in 2.4.  su hangs for 2-3 minutes.
strace tracks it to a wait that seems to have stalled.  Often, logins and a
handful of other situations do the same.  I mentioned this to Takashi Oe, as I
first noticed it when trying his NuBus 2.4 kernel, but he told me it's a 2.4
thing, possibly relating to VM.  I don't think this is related to the network
problem, or could it be a wakeup problem?

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
