Mime-Version: 1.0
Message-Id: <p05111701b90ef6f7b448@[10.0.0.42]>
In-Reply-To: 
 <Pine.LNX.4.44.0205201347260.24446-100000@horus.office.aol.com>
References: <Pine.LNX.4.44.0205201347260.24446-100000@horus.office.aol.com>
Date: Mon, 20 May 2002 12:18:53 -0700
To: brad allison <jackal@aol.net>,
	YellowDog Linux General <yellowdog-general@lists.terrasoftsolutions.com>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Nvidia support
Cc: Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:54 PM -0400 5/20/02, brad allison wrote:

>Nothing I did on the command line changed resolution.
>
>So, then I installed MacOSX on one of the other partitions.  Inside MacOSX
>I set the resolution to 1280x1024, then rebooted.  Now the yaboot prompt,
>boot prompt, and console messages all come up at 1280x1024.
>
>I booted with ben's kernel with the "novideo" option in yaboot.conf into
>init 3.
>
>Then I re-ran Xconfiguration.  Added lines to /etc/X11/XF86Config-4 from
>fbset -x, and changed the driver to "nv".
>
>When I run X it -still- comes up in 1280x960 @ 60.00.
>
>So it's ignoring both the fb settings -and- the XF86Config-4 and booting
>into whatever resolution it can sync too.

Check /var/log/XFree86-0.log.  It may have some information on why
XF86 is selecting another resolution.

BTW, you may actually want 1280x960 on your monitor.  x960 is a 4:3
aspect ratio resolution, x1024 is 5:4.  Most monitors are 4:3, so you
can't expand a 5:4 resolution to fill the screen on them without
getting an image that is squashed vertically.  The only 5:4 monitors
I know of are 17" and 18" LCD monitors whose native resolution is
1280x1024.

--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
