Message-ID: <19991018172459.2605.rocketmail@web1005.mail.yahoo.com>
Date: Mon, 18 Oct 1999 10:24:59 -0700 (PDT)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: Re: How does it all fit together?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi Patrick.  I have a Powerbook Wallstreet II series,
and my framebuffer X server has limited rudimentary 2D
acceleration because I tell BootX to tell my kernel
video driver certain settings, and then when I run
Xconfigurator, it autodetects the driver's current
state.
	I found this by gleaning the mailing list archives at
http://lists.linuxppc.org.  I found some URL's (which
i've LOST in a filesystem crash) to some people who've
basically documented Powerbook video, kernels, and are
distributing precompiled kernels on some guy's random
web site.
	That's basically all I've ever seen in the way of
getting particular system-specific non-default
features.
	My advice is to do some docs, put them in the basic
style of the linuxppc.org web pages, and send them to
jhaas@linuxppc.org.
	Thanks!

--- Patrick Callahan <pac1@tiac.net> wrote:
> 
> 
> Where can I read and research about how the video
> settings and the
> software that uses the settings  fit together in the
> context of he MAC
> OS, BootX, Linux Boot, Linux Console and X Window
> processes on PPC
> hardware.
> 
> The relevant settings are:
> 
>     MacOS Monitor Settings
> 
>     BootX
>         no video driver option checked/unchecked
>         several kernel arguments related to video
> 
>     XConfig values for monitor settings.
> 
> Various video drivers.
> 
> At the moment, I can make Linux and X work by
> choosing values that are
> known to work on my hardware.  Using values for
> bootX kernel arguments
> suggested by others in various mail messages also
> frequently works.
> 
> I'd like to go beyond this and find or write
> documentation on these
> items as a group, explaining how they work together
> with specific pieces
> of software to determine the final outcome you see
> on your monitor.  I'd
> like to pull together information that will
> illuminate how things
> actually work together, in addition to documenting
> sets of values that
> actually work on various machines.
> 
> If there is  any information like this out there,
> I've been unable to
> find it so far.  If you know of any, can you point
> me in the right
> direction?
> 
> If there is no existing documentation along these
> lines, is anyone
> interested in working on such a project?
> 
> 
> 


=====
"Don't expect your own messiah; this neverworld which you desire is
only in your mind." -- http://www.dreamtheater.net/songb4.htm#IV5

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
