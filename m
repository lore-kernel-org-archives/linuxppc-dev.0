Message-ID: <3A807ACA.E23A7B47@mvista.com>
Date: Tue, 06 Feb 2001 17:29:30 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
        Tom Gall <tgall@rochcivictheatre.org>,
        Troy Benjegerdes <hozer@drgw.net>, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es>
		<3A6DCBBE.60AB54CE@mvista.com>
		<14975.55329.292764.981333@tango.linuxcare.com.au>
		<3A806897.9D2D480E@mvista.com> <14976.29084.376745.660244@tango.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> > That's not what MMU context means, well at least the way I have
> > learned to use it in the past.  An MMU context is supposed to represent
> > the virtual mapping of memory objects.  Linux has memory objects
>
> No, an MMU context represents an address space, or more precisely the
> set of virtual to physical mappings in an address space,...

Isn't that what I just said above :-)?  Your original message said
you want to map some context to just a few of the VSIDs, that is what
I said isn't correct.


> On machines like the x86 where the MMU doesn't know about MMU contexts
> you have to basically context-switch the whole MMU including the TLB.
> Fortunately we don't have to do that. :)

Well, an MMU doesn't have to know about contexts (or have something
called a 'context register') for you to implement MMU context management.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
