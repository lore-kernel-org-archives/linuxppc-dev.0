Message-ID: <C18BA5DDB58DD511BD0700C0DF0DD45028B27D@NTSERVER4>
From: Phil Thompson <philt@4bridgeworks.com>
To: "'Matt Porter'" <mporter@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: 440GX Support on Linux v2.4
Date: Wed, 25 Feb 2004 16:35:31 -0000
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: Matt Porter [mailto:mporter@kernel.crashing.org]
> Sent: 25 February 2004 16:32
> To: Phil Thompson
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: 440GX Support on Linux v2.4
>
> On Wed, Feb 25, 2004 at 03:54:08PM -0000, Phil Thompson wrote:
> >
> > I need to bring up Linux 2.4 on an IBM 440GX evaluation board (Ocotea I
> > assume). It is supported on Linux 2.6.
> >
> > What's my best option for doing this...
> >
> > Somebody already has a patch for 2.4? :)
> >
> > Backport the code from 2.6?
> >
> > Enable 440GP compatibility mode and hack the existing 2.4 Ebony board
> > support?
> >
> > Something else?
>
> Clone linuxppc-2.4 and build using the Ocotea config? :)
>
> -Matt

Yes, it was a case of picking the right tree.

Thanks,
Phil

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
