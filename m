Date: Wed, 16 Oct 2002 19:27:12 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stefan Jeglinski <jeglin@4pi.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: part deux Re: Radeon 7000 in 9500 - which slot?
Message-ID: <20021016192712.A971@suse.de>
References: <p05100302b9d2ade72041@[192.168.0.8]> <20021016121613.26836@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021016121613.26836@192.168.4.1>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


begin  On Wed, Oct 16, Benjamin Herrenschmidt wrote:

>
> >Have moved the 7000 to the top slot on the 9500, 2 monitors attached.
> >
> >When using 2.4.20-pre9-ben0, booting into RL3 (not troubleshooting X
> >at this point) and kernel arg video=radeon:1024x768-16@75, the
> >console boot briefly appears to start in accelerated mode, then the
> >monitor goes black and stays that way. However, I can tell from
> >listening to the disks that the boot proceeds normally.
>
> What kind of monitors ? 2 CRTs ? 1 LCD and 1 CRT ?
>
> The problem is apparently due to radeon_get_moninfo not finding
> anything, can you eventually force rinfo->crtDisp_type to MT_CRT
> and see if that helps ?

I see something similar here.
It does work when booting with BootX App, but not with miboot.


Gruss Olaf

--
 $ man Notes

BUGS
       You need http://www.sauerstoff-laden.de/ soon...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
