Date: Mon, 20 Mar 2000 20:53:46 +0100
From: Florian Lohoff <flo@rfc822.org>
To: David Edelsohn <dje@watson.ibm.com>
Cc: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC/MCA RS/6000 port ?
Message-ID: <20000320205346.F1363@paradigm.rfc822.org>
References: <paubert@iram.es> <200003200257.VAA26624@mal-ach.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200003200257.VAA26624@mal-ach.watson.ibm.com>; from David Edelsohn on Sun, Mar 19, 2000 at 09:57:45PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Mar 19, 2000 at 09:57:45PM -0500, David Edelsohn wrote:

> 	I do not have any hardware specs for these machines offhand, but
> the interrupt controller may very well be PC-like cascaded 8259s.

> 	The PPC601 was a POWER architecture chip with additional user-mode
> PowerPC instructions.  It was based on the existing RSC (RIOS Single Chip)
> processor that IBM already was using and allowed the first PowerPC chip
> implementation to be developed and deployed very rapidly.  The supervisor
> state of the chip was all POWER architecture, not PowerPC Books II and
> III.  The direct store segments were a way to access special devices on
> the I/O bus.

What does this mean in concern to the existing PPC port ? As i understand
the linuxppc port does already run on 601 - So the CPU is already
supported - Leaves us with bootstrap/bootprom and special architecture
(interrupts, scsi controller, serial ports etc)

Right ?

Flo
--
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
