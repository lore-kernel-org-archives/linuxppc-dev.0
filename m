From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: <bart@ardistech.com>, <joakim.tjernlund@lumentis.se>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8xx i2c refers to unspecified chip errata
Date: Fri, 11 Oct 2002 14:31:37 +0200
Message-ID: <FCEAKDJJAPHPLJFINDAJMENOCJAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3DA6C0C3.A34624CA@ardistech.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Bart and Joakim,

Well. No, I'm not shure. But I see what you mean Bart. :) I'll see what
happens now.

And I have a question to Joakim. In your code you wrote (cpm_iic_init):

	i2c->i2c_i2mod = 0x80; /* Filter clock */

I think this is not what you intended. I didn't find that bit (bit 0) in my
862 manual. But there's the FLT flag (bit 4) that matches your comment. So I
think It should be:

	i2c->i2c_i2mod = 0x08; /* Filter clock */

Thanks, Stephan

> -----Original Message-----
> From: bart [mailto:bart]On Behalf Of bart@ardistech.com
> Sent: Freitag, 11. Oktober 2002 14:15
> To: Stephan Linke
> Cc: Linuxppc-Embedded
> Subject: Re: 8xx i2c refers to unspecified chip errata
>
>
> Hi Stephan,
>
> > I had a look at you code. Some of the changes I already did in
> my code. :)
> > I couldn't find any thing that looks like it's fixing the memory problem
> > that you mentioned. I'm looking for a memory problem by my self
> and I wonder
> > what you might have figured out.
> >
> You're sure it not a cache invalidate problem you're looking at?
>
> Cheers,
> 	Bart
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
