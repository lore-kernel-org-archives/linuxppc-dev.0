Subject: Re: Problems with AGP Apple UniNorth support in 2.4.19-pre7-ben0
	kernel
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Bill Fink <billfink@mindspring.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020509003815.6873bbbd.billfink@mindspring.com>
References: <20020424025457.7b323ff0.billfink@mindspring.com>
	<20020509003815.6873bbbd.billfink@mindspring.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 09 May 2002 10:59:57 +0200
Message-Id: <1020934797.2414.6628.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2002-05-09 at 06:38, Bill Fink wrote:
>
> I see that the changes I suggested have been incorporated into the
> 2.4.19-pre8-ben0 kernel.  I was able to successfully build and boot
> this kernel on my dual 500 MHz G4 (UP kernel), but the DRI was no
> longer functional (as reported by glxinfo).
>
> I had this working with the 2.4.18-ben0 kernel, with modified versions
> of drivers/char/drm/r128_{drv,state}.c that I got from a friend who I
> believe got them from the XFree86 CVS at the time.  That r128_state.c
> is now included in the 2.4.19-pre8-ben0 kernel but the new r128_drv.c
> was not included.  The diff is pretty innocuous:
>
> 42c42
> < #define DRIVER_DATE           "20010405"
> ---
> > #define DRIVER_DATE           "20010917"
> 45,46c45,46
> < #define DRIVER_MINOR          1
> < #define DRIVER_PATCHLEVEL     6
> ---
> > #define DRIVER_MINOR          2
> > #define DRIVER_PATCHLEVEL     0
>
> I figured what the heck, I didn't have anything to lose, so I went ahead
> and made the change, and now the DRI is working once more!

This is only valid if all of the r128 DRM is indeed 2.2 .


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
