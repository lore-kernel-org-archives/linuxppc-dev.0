Date: Fri, 20 Jul 2001 11:49:30 +0100
Subject: Re: Video acceleration on IMSTT with bk (and Ben's) 2.4.7-pre6
	 kernel
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Simon Piette <simonp@Sat.QC.CA>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010720104923.458D3DBA98@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wrote:
>> I just compiled 2.4.7pre6 from Ben's tree, and another one from bk, with
>> the same results. It compiled without any problems, but I can't have
>> accelerated video. I use "video=imsttfb:vmode:17,cmode:16 video=ofonly"
>> as kernel args to have a working unaccelerated video. Without ofonly, I
>> get some blue dots forming a very distortioned screen of what should be
>> there (linux logo and kernel verbosity). Without the imsttfb part, it
>> won't work after the initial boot screen: it stops after
> [snip]
>
> BK 2.4.7-pre6:
>
> OK.  It comes up for me 9600/233 with video acceleration and runs "single".
>
> However, it won't start the X-server the error is something like:
>
>  _X11TransConnectUNIX??? errno = 111

This is because I was being a dumb-bunny ...

and had forgotten that I no longer use Xpmac compat on my build system (but
still use Xpmac on the IMSTT -- anyone know if XF-4.1 is OK on IMSTT?)

It's all OK now (as of a build of 2.4.7-pre8 this morning).

> Other symptom is that the splash screen #cpus penguin is missing it's
> background.

this symptom remains (as does missing graphics on the redhat logo etc. on
the KDE2 login splash screen).

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
