Message-ID: <20020310173636.42443.qmail@web11102.mail.yahoo.com>
Date: Sun, 10 Mar 2002 09:36:36 -0800 (PST)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Re: 2.4.18-ben0 on G4 SMP: do_IRQ waiting for irq lock
To: laforge@gnumonks.org
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Harald,
I've seen the same problem with cups on my G4 dual
450.

In addition, my machine hangs whenever the macserial
driver is closed (e.g., open /dev/ttyS0 with minicom,
the exit).

Does your machine do this as well?

-roger

On Sat, 9 Mar 2002 10:43:28 +0100,
laforge@gnumonks.org wrote:
>On Fri, Mar 08, 2002 at 07:34:09PM +0100,
benh@kernel.crashing.org wrote:
>> Could be a driver bug showing up, difficult to say.
The problem definitely
>> doesn't happen here (dual G4 450Mhz, 2x7400 CPU
with highmem). The fact that
>> the IRQ lock can be held by the other CPU is normal
though, both CPUs don't
>> take external IRQs but decrementer ones for example
happen on both.
>>
>> That said, I don't know what is causing your
problem.
>
>I've now managed to get the kernel running - so far
without any crashes for
>one day.
>
>The problem seemed connected with the cups daemon. If
I don't start (or use)
>any part of the cups (common unix printing system),
it runs fine.
>
>I don't know what cups is trying to do, since there
are no local printers
>configured. Everything it is supposed to do is to
submit remote printjobs
>to my printer server.
>
>As of drivers, the only hardware driver (apart from
standard pmu, aty128fb,
>sungem) I'm using is tulip for a 21x4x network board.
>
>But the problems are not related with this network
interface, since I'm
>heavily using it for NFS, etc. I've also tried to
pingflood the machine
>on both network interfaces - no problem.
>
>> Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
