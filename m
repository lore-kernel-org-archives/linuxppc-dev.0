Date: Mon, 14 May 2001 11:28:59 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Eli Chen <eli@routefree.com>
Cc: Brian Kuschak <brian.kuschak@skystream.com>,
	"'Dan Malek'" <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
In-Reply-To: <07ab01c0da7e$8d645070$4b00000a@foolio1>
Message-ID: <Pine.HPX.4.10.10105141118120.29518-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 11 May 2001, Eli Chen wrote:

> No luck here.  I checked the patched kernel running Brian's test after an
> hour and it had frozen up, with one de_put message.

Do you have a stack trace or something similar ?

Does my patch increase the time to failure ?

I've not yet got anything better than these messages without any context
(stack trace, etc). I'd prefer to have them with symbols, but even with
only register contents it would be better than nothing.

I'm currently thinking of ways to catch the occurrences of the problem.
The difficuly is that brute force debugging likely won't work on what
looks like a subtle timing problem. So I need a non-invasive check, and
that's far from trivial.

Along with the stack trace, please include as many details as possible on
your system.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
