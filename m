Date: Fri, 26 Nov 1999 10:06:28 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Dan Malek <dan@netx4.com>
cc: Christian Zankel <chris@mvista.com>, cort@fsmlabs.com,
        linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
In-Reply-To: <383D92CF.6ECD12D3@netx4.com>
Message-ID: <Pine.GSO.4.10.9911261005360.29385-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 25 Nov 1999, Dan Malek wrote:
> Geert Uytterhoeven wrote:
> > Alternatively, you can base your decisions on specific features that are shared
> > among different machine types, and say
> > 
> >     if (has_feature_a) {
> >         ...
> >     }
> > 
> > instead of
> > 
> >     #if defined(CONFIG_x) || defined(CONFIG_y) || defined(CONFIG_z)
> >     ...
> >     #endif
> 
> Yes, but one of the things I am trying to do is reduce the
> code size and instructions to execute.  On a 500 MHz G4 with
> a Gigabyte of memory, a few extra instructions is no big deal.
> On a 33 MHz 8xx with 8 Mbytes of memory, you watch all of this
> pretty closely :-).

So what's wrong with the approach above? All unused code will be optimized away
by the compiler. There's no difference between the first and the second
version, except that the first one is more readable.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
