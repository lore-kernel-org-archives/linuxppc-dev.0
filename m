Date: Sun, 25 Aug 2002 12:09:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Paul Mackerras <paulus@samba.org>, acurtis@onz.com,
	Ppc Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260 Memory Management
Message-ID: <20020825190950.GB15348@opus.bloom.county>
References: <3D65C19C.2070503@embeddededge.com> <NCBBIINEHIPFGJPLBEIFAEBNDLAA.acurtis@onz.com> <15718.52527.24904.317204@argo.ozlabs.ibm.com> <3D6797F8.4000106@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D6797F8.4000106@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Aug 24, 2002 at 10:28:08AM -0400, Dan Malek wrote:
>
> Paul Mackerras wrote:
>
> >Dan, can we *please* take out the #define request_irq request_8xxirq
> >and just use request_irq like everyone else?
>
> I was doing that as part of the 2.5 interrupt changes, but if you
> want to do it now we can try.  On the 8260 it's not as bad as the 8xx,
> but you have to ensure the legacy and PCI interrupts are outside of
> the internal controller and CPM ranges.

Well, for 2.4 and 8260, this is quite easily done, as was shown in the
patch which remove request_8xxirq altogether a while back.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
