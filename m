Date: Thu, 20 Dec 2001 04:12:18 -0700
From: Matt Porter <mporter@mvista.com>
To: Marius Groeger <mag@sysgo.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compile Penguin PPC for x386?
Message-ID: <20011220041217.B7195@cx258813-a.chnd1.az.home.com>
References: <20011212165819.D1790@borg.org> <20011212122102.B21676@cx258813-a.chnd1.az.home.com> <200112201057.fBKAvGW08553@dagobert.svc.sysgo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200112201057.fBKAvGW08553@dagobert.svc.sysgo.de>; from mag@sysgo.de on Thu, Dec 20, 2001 at 11:57:16AM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 20, 2001 at 11:57:16AM +0100, Marius Groeger wrote:
>
> In linux.ppc.embedded, Matt Porter wrote:
> >
> > No, the PPC MM changes in 2_4_devel rely on changes to the generic
> > MM API that aren't yet in the kernel.org release.  You could modify
> > the appropriate files in arch/i386/mm/ and include/asm-i386/ to match
> > if you like.
>
> Matt, do you know the origin of those changes? Are they an invention of the
> linuxppc people, or part of the 2.5 tree? I'm asking because I'm afraid that
> these changes might not make it into kernel.org release for a LONG time...

Ask Paulus about the status of them being included.  My understanding
is that he has been working with the appropriate parties (i.e. Linus
and co) on these changes.

If you want something that closely tracks kernel.org then use
linuxppc_2_4.  A merge of most of the "new" ports from
linuxppc_2_4_devel is planned now that organizational changes
are settling down.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
