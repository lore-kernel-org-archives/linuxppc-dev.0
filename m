Subject: Re: equivalent of touch_nmi_watchdog
From: Rajarshi Das <rajarshi@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1088514406.13868.48.camel@gaston>
References: <1088509774.22425.54.camel@darya>
	<1088514406.13868.48.camel@gaston>
Content-Type: text/plain
Date: 29 Jun 2004 19:30:14 +0530
Message-Id: <1088517617.18965.65.camel@darya>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Its basically dumping code. After a panic has happened, interrupts are
inhibited, all CPUS (except the host cpu) are frozen, and for each page
of data, the dump module writes the dump to disk by calling the host
adapter's interrupt handler till I/O completes.

Rajarshi.

On Tue, 2004-06-29 at 18:36, Benjamin Herrenschmidt wrote:
> On Tue, 2004-06-29 at 06:49, Rajarshi Das wrote:
> > Hi,
> > I am running some code which needs interrupts to be disabled for a
> > reasonable amount of time. A "touch_nmi_watchdog" call is done before
> > this code gets called on i386 platform. How do I do it on ppc64 ? I am
> > using a power 3 machine (type 7044-170) (uniprocessor) and a 2.6.6
> > kernel.
>
> Can you tell us more about your code ? It's never a good idea to disable
> interrupts for more than a few microseconds ...
>
> Ben.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
