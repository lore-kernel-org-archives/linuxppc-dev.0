Date: Wed, 17 May 2000 13:36:47 -0400 (EDT)
From: Worth <haworth@ncal.verio.com>
To: Sergio Brandano <sb@dcs.qmw.ac.uk>
cc: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>, linuxppc-dev@lists.linuxppc.org,
        debian-powerpc@lists.debian.org
Subject: Re: Pismo status 
In-Reply-To: <200005171514.QAA00462@copper.dcs.qmw.ac.uk>
Message-ID: <Pine.SOL.4.10.10005171219570.17780-100000@ncal.verio.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 May 2000, Sergio Brandano wrote:

>
> > What should happen is that the OS should realize that the processor
> > is getting too warm, and turn on the fan before that limit is
> > reached.
>
>  ... relying on the OS for cooling the CPU?
>  What is the advantage of doing it?
>  What happened to good-old control theory?
>
>  Sergio
>
>
>

It's unlikely that the OS is involved in controlling the fan. To
depend upon the OS would be a very stupid design, as what would
happen if it goes into la-la land in a processor-intensive infinite
loop...? The PMU is a uproc with it's own firmware and should be
managing the fan, provided the fan isn't simply controlled
by a thermo-switch. However, there is no documentation to that
effect, but I haven't found any sign of fan control in the
Darwin drivers (which added some Core99 support in the last
update).

Others have complained of the fan being on all the time, my PB2K
500 seems to have its on quite often and it never gets anywhere near
as hot as it gets idling in MacOS (which can get hot enough to
cause sweaty palms when typing).

It is very important that you leave the screen up when the
system is on. Convection through the keyboard is a major part
of that case's cooling design, which is why MacOS does not give
you the option of not going into sleep when it is closed (Apple has
released a tech note on that). Also use hdparm to keep the disks
from running more than necessary, they generate a lot of heat,
particularly the DVD.

Beyond that, until Apple releases some definitive documentation --
yah, right -- you pays your money and you takes your chances...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
