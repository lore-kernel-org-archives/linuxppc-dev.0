Message-ID: <396F6052.604027EE@norran.net>
Date: Fri, 14 Jul 2000 20:47:46 +0200
From: Roger Larsson <roger.larsson@norran.net>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linux-audio-dev@ginette.musique.umontreal.ca,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [linux-audio-dev] [ANN] First latency test results for linuxPPC
 [2.2.17pre10-ben2]
References: <200007132354.AAA20365@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> Hi,
>
> I've posted the results of Benno's latency tests applied to 2.2.17pre10-ben2
> on LinuxPPC.
>
> http://www.drfruitcake.com/linux/linuxppc.html
>
> No big surprises - although the PPC /proc fs seems to be a little slower
> than the x86 one...
>
> Working on 2.4.0-test4 & thence to Andrew's patches on LinuxPPC...
>
> ciao,
> Iain.


Hi,

The green ticks on X11 test are interesting - something with a higher
prio than
the SCHED_FIFO max takes the processor away from it and runs for more
than 1 ms.

The only thing that can do that is interrupt routines / back handlers...
(try to find this one)

Disk read looks nice - others looks ...


/RogerL

--
Home page:
  http://www.norran.net/nra02596/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
