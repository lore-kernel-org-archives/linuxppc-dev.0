Date: Wed, 16 Oct 2002 11:12:34 -0700 (PDT)
From: Ani Joshi <ajoshi@unixbox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stefan Jeglinski <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: part deux Re: Radeon 7000 in 9500 - which slot?
In-Reply-To: <20021016121613.26836@192.168.4.1>
Message-ID: <Pine.BSF.4.44.0210161110480.97189-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It is not detecting the heads properly because on many "mac" radeons, the
firmware doesn't initialize the SCRATCH registers properly which contain
information about display type.  There is no reliable method of probing
display type on ppc so I will end up adding a display type option to
radeonfb next version.


ani


On Wed, 16 Oct 2002, Benjamin Herrenschmidt wrote:

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
>
> Ben.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
