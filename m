Message-ID: <638AA0336D7ED411928700D0B7B0D75BB32414@mail2.aiinet.com>
From: "Gessner, Matt" <mattg@aiinet.com>
To: "'Dan Malek'" <dan@embeddededge.com>,
	"Gessner, Matt" <mattg@aiinet.com>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: BDI2000 and failed MMU translations
Date: Wed, 23 Jan 2002 17:22:31 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It's straight 2_4.  I wasn't stopping at start_kernel though.
I don't have PTBASE set up.

Not sure what I need.
Following some advice from mattl on #mklinux, I'm going to
break at start kernel FIRST, then connect with BDI, then
see if I can look at my data.

THX and Regards,

Matt

> -----Original Message-----
> From: Dan Malek [mailto:dan@embeddededge.com]
> Sent: Wednesday, January 23, 2002 5:24 PM
> To: Gessner, Matt
> Cc: 'Linux PPC'
> Subject: Re: BDI2000 and failed MMU translations
>
>
> Gessner, Matt wrote:
>
>
> > I get a LOT of failed MMU translations reported.
> > Is this b/c I have something misconfigured?
> > I'm running 2.4.18 out of bk on an 860P.
>
> Is it 2_4 or 2_4_devel?  I'm travelling for about the next
> week, but will check it out when I return (if I can borrow
> a BDI2000 from someone :-).
>
> Has it worked on previous kernel versions?  If so, which ones?
>
> Thanks.
>
>
> 	-- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
