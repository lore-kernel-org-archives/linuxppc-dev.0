Message-ID: <3938C6EC.40FFE599@student.ethz.ch>
Date: Sat, 03 Jun 2000 10:50:52 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: "David L. Thompson" <dthompsn@vizsolutions.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree86-4.0 Status?
References: <200006030459.XAA19940@lists.linuxppc.org> <p04320405b55e4e6caf0a@[192.168.1.1]>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"David L. Thompson" wrote:
>
> I was wondering if anybody could comment on the status of
> XFree86-4.0. I tried installing this on a PowerBook G3/250 and have
> had no luck. I've seen just a few posts in regards to "support isn't
> there yet" so I was wondering if anybody could comment.

I suppose that's Mach64 hardware, so you have to use the fbdev driver _and_ a
patched kernel to correct broken OF PCI memory mappings.

Ask Michael Schmitz :)


Michel


--
I believe the technical term is "Oops!"
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
