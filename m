Message-ID: <383A716F.D020496C@fadata.bg>
Date: Tue, 23 Nov 1999 12:50:23 +0200
From: Momchil Velikov <velco@fadata.bg>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Cort Dougan <cort@fsmlabs.com>, linuxppc-dev@lists.linuxppc.org,
        paulus@linuxcare.com
Subject: Re: bootloader & head.S weirdness
References: <19991123113504.011766@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> 
> On Mon, Nov 22, 1999, Cort Dougan <cort@fsmlabs.com> wrote:
> 
> >CC: linuxppc-dev@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
> >----------
> >Not always.  Keep in mind we have several machine types that follow the
> >same patch there.  We don't always enter with OF and OF doesn't always give
> >1:1 mappings, either.
> 
> Yes, I agree. but I beleive the piece of bootloader appended to the head
> of the kernel image or the early bootloader used (quik ?) should take
> care of those very weird case and of mapping the kernel 1:1 before
> entering it.

Please, excuse my ignorance, but why not just set real-mode OF variable
to true (maybe in the ELF .note section) ?

Regards,
-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
