Message-ID: <20001106153722.12662.qmail@web219.mail.yahoo.com>
Date: Mon, 6 Nov 2000 07:37:22 -0800 (PST)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: Re: Airport debug (was Re: airport woes?)
To: Chris Leishman <masklin@debian.org>, Rod Stewart <stewart@lab43.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Cc: Chris Leishman <masklin@debian.org>, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I don't have an Airport but am familiar with
programming linux network device drivers.

This symtom sounds like a it could be a classic tbusy
(transmit busy ) getting  stuck on in the driver in
the network device structure.

--- Chris Leishman <masklin@debian.org> wrote:
>
> On Thu, Nov 02, 2000 at 03:15:58PM -0500, Rod
> Stewart wrote:
> <snip>
> >
> > Anyone know if this is fixed, or a work around?
> I've got the same setup,
> > with the same problem.  My ssh connections over
> airport freeze.
> >
> > Thanks,
> > -Rms
>
> No idea yet - but I'm not all the familiar with
> device drivers, etc, yet.
>
> I do know that the airport_tx method stops getting
> called when the lock-up
> occurs.  Why it doesn't get called I don't know.
>
> Regards,
>
> Chris
>
>
> --
>
----------------------------------------------------------------------
>        Knuth: premature optimization is the root of
> all evil.
>
----------------------------------------------------------------------
> Reply with subject 'request key' for GPG public key.
>  KeyID 0xB4E24219
>
>


=====
D.J. Barrow Linux for S/390 kernel developer
eMail: djbarrow@de.ibm.com,barrow_dj@yahoo.com
Phone: +49-(0)7031-16-2583
IBM Germany Lab, Schönaicherstr. 220, 71032 Böblingen

Thousands of Stores.  Millions of Products.  All in one Place.
http://shopping.yahoo.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
