Message-ID: <001001bfa35e$cb0021a0$0201a8c0@home>
From: "Jeff Millar" <jeff@wa1hco.mv.com>
To: "Dan Malek" <dan@netx4.com>,
        "Marcus Sundberg" <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Cc: "Pavel Roskin" <pavel_roskin@geocities.com>,
        "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>,
        <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.LNX.4.21.0004071011570.19406-100000@sunapee.transcept.com> <38EE0267.FB881499@embeddededge.com> <kfywvm6s3dz.fsf@kieraypc01.p.y.ki.era.ericsson.se> <38F200CF.B4A07187@embeddededge.com>
Subject: Re: Software Emulation Exception...
Date: Mon, 10 Apr 2000 22:36:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pavel was running on a virgin RPX-lite board with PCMCIA adapter and a
Sandisk flash disk plugged in.  Not on the new hardware.  So, is it a
problem with the RPX board or the Sandisk?

jeff


----- Original Message -----
From: "Dan Malek" <dan@netx4.com>
To: "Marcus Sundberg" <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Cc: "Pavel Roskin" <pavel_roskin@geocities.com>; "Wohlgemuth, Jason"
<jason_wohlgemuth@gilbarco.com>; <linuxppc-embedded@lists.linuxppc.org>
Sent: Monday, April 10, 2000 12:26 PM
Subject: Re: Software Emulation Exception...


>
> Marcus Sundberg wrote:
>
> > Well, it also happens to be typical to the MM problem solved by
> > the patches at http://www.zeta.org.au/~linsol/.....
>
> That's pretty interesting, since the Software Emulation trap is
> caused by fetching trash from memory, and the MMU changes are to
> properly track dirty data pages.  I don't buy it.  All you did
> by adding these changes was eliminate (or change) the data TLB
> miss timing.  Have you ever looked at the 8xx bus when it gets
> a TLB fault?  Pretty damn weird.  I've seen several external devices
> not behave properly because of this.
>
>
> > And by Pavel's description it's almost 100% certain that the MM
> > bug is the problem.
>
> Well, almost 100% doesn't cut it for me.  If you can't determine the
> actual cause of the problem and prove it has been corrected, it is
> still broken.
>
>
>
> -- Dan
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
