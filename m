Date: Wed, 16 Oct 2002 21:53:44 +0200
From: Olaf Hering <olh@suse.de>
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: part deux Re: Radeon 7000 in 9500 - which slot?
Message-ID: <20021016215344.C11834@suse.de>
References: <p05100302b9d2ade72041@[192.168.0.8]> <20021016121613.26836@192.168.4.1> <20021016192712.A971@suse.de> <p05111b14b9d3614c6807@[63.220.231.176]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p05111b14b9d3614c6807@[63.220.231.176]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


begin  On Wed, Oct 16, Stefan Jeglinski wrote:

>
> > > The problem is apparently due to radeon_get_moninfo not finding
> >> anything, can you eventually force rinfo->crtDisp_type to MT_CRT
> >> and see if that helps ?
> >
> >I see something similar here.
> >It does work when booting with BootX App, but not with miboot.
>
> I'm using BootX, so I would respectfully disagree :-)

I used the novideo driver checkbox once.
But with this checkbox disabled and 1024x768-75 in MacOS, all I get is a
stripe on the screen.
Using 640x480-120 in MacOS and it works also in Linux.
I must note that the XF 4.2 radeon driver can open the display
correctly, even with broken kernel framebuffer driver.


Gruss Olaf

--
 $ man Notes

BUGS
       You need http://www.sauerstoff-laden.de/ soon...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
