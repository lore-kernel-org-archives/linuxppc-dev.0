Message-ID: <3BB264BC.8E7291FE@mvista.com>
Date: Wed, 26 Sep 2001 16:29:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: paulus@samba.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Adding 'bus_offset' to pci_controller
References: <3BB24A6B.BADCF16E@mvista.com> <15282.23932.770208.130313@cargo.ozlabs.ibm.com> <3BB2639D.A44BCA16@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Mark A. Greer" wrote:

> Paul Mackerras wrote:
>
> > For now something like what you have suggested should be OK except
> > that I would note that you could use the host->first_busno field,
> > which already exists, instead of adding a new field.
>
> Oh man, DUH...
>
> Thanks Paul, I'll make the change & push it in.

Wait, I can't b/c then *everyone* will have this subtraction happen and
everyone but me would be broken.
With a separate field, I don't mess up other  board ports.

Another way to go would be to #ifdef your suggestion into indirect_pci.c
for my board only.
Which do you prefer?

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
