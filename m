In-Reply-To: <36932B99.20AE3AA4@mpifr-bonn.mpg.de>
Date: Wed, 6 Jan 1999 11:02:56 +0100
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>,
        Albrecht =?ISO-8859-1?Q?Dre=DF?= <ad@mpifr-bonn.mpg.de>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Strange PMAC IDE performance problem
Message-Id: <19990106110256.031920@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 6, 1999, Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de> wrote:

>I use the latest test kernel form your web page (2.1.130 with patches; btw.
>the
>trackpad patch is REALLY great!!) and boot with BootX 1.0.1. Bogus interrupts
>appear both with nothing attached to external SCSI and with a tape drive. I
>get
>very few bogus irq's from via_pmu_interrupt (c01d43fc, c01d4410) and
LOTS from
>do_IRQ (c0005518) in both cases. According to /proc/interrupts, doing a dd of
>200 MBytes form /dev/zero to the internal hd resulted in 31 bad irq's from
>do_IRQ (and a transfer rate of 1.71 MB/s).

By curiousity, did someone tried to locate the exact instruction in
do_IRQ when those bogus interrupt happens ? Looks it's always the same...
On MacOS, CodeWarrior has a useful disassembly tool that mixes C and asm
output for that, but I guess there is probably something 1000 times
better on Linux, I just need to know the command line ;-)


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
