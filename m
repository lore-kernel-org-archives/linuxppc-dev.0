Subject: Re: equivalent of touch_nmi_watchdog
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rajarshi Das <rajarshi@in.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1088517617.18965.65.camel@darya>
References: <1088509774.22425.54.camel@darya>
	 <1088514406.13868.48.camel@gaston>  <1088517617.18965.65.camel@darya>
Content-Type: text/plain
Message-Id: <1088516776.15069.50.camel@gaston>
Mime-Version: 1.0
Date: Tue, 29 Jun 2004 08:46:16 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2004-06-29 at 09:00, Rajarshi Das wrote:
> Its basically dumping code. After a panic has happened, interrupts are
> inhibited, all CPUS (except the host cpu) are frozen, and for each page
> of data, the dump module writes the dump to disk by calling the host
> adapter's interrupt handler till I/O completes.

Hrm... a bit scary but might actually work. I don't think we have
a clean interface for whatever watchdog service HV may provide
though, but I'll let others comment on that.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
