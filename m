Message-ID: <3A9A2FBF.B304ADD1@valinux.com>
Date: Mon, 26 Feb 2001 21:28:15 +1100
From: Gareth Hughes <gareth@valinux.com>
MIME-Version: 1.0
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: "Timothy A. Seufert" <tas@mindspring.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: r128 DRI driver now fully functional on PPC
References: <3A76769B.87242FAA@valinux.com>
				 <v04220800b6bbb8f01525@[10.0.0.42]> <3A963519.C439E7C0@valinux.com> <v04220800b6be6735bfd4@[165.247.215.42]> <3A9A246D.72D1B5BE@iiic.ethz.ch> <3A9A2A9D.8A779B@valinux.com> <3A9A2E16.6F679EF3@iiic.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
>
> First I thought I'd stand corrected, but on second thought - it looks for
> /usr/X11R6-DRI/lib/modules/dri/r128_dri.so on my machine (if ProjectRoot is
> /usr/X11R6-DRI), but /usr/X11R6-DRI/lib isn't in ld.so.conf . It even looks
> there if I set LD_LIBRARY_PATH to the exports/lib directory in the build tree.
>
> Am I still not getting it? :)

Sorry, my mistake.  libGL.so opens $MODULEDIR/dri/r128_dri.so, where
$MODULEDIR is defined by the Imakefiles (and would be
/usr/X11R6-DRI/lib/modules in your case).  So, the problem may be that
the wrong libGL.so is being picked up -- and this *is* an ld.so.conf
problem.

-- Gareth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
