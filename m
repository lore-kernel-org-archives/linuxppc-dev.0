Message-ID: <3A9B91EA.7DCFFEF3@valinux.com>
Date: Tue, 27 Feb 2001 22:39:22 +1100
From: Gareth Hughes <gareth@valinux.com>
MIME-Version: 1.0
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: r128 DRI driver now fully functional on PPC
References: <3A76769B.87242FAA@valinux.com>				
	 <v04220800b6bbb8f01525@[10.0.0.42]> <3A963519.C439E7C0@valinux.com>
	 <v04220800b6be6735bfd4@[165.247.215.42]> <3A9A246D.72D1B5BE@iiic.ethz.ch>
	 <3A9A2A9D.8A779B@valinux.com> <3A9A2E16.6F679EF3@iiic.ethz.ch>
	 <3A9A2FBF.B304ADD1@valinux.com> <v04220800b6c12899d73e@[10.0.0.42]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Timothy A. Seufert" wrote:
>
> I still have the problem with keyboard/mouse input being ignored once
> a GL app starts.  A friend suggested disabling DGA, but that didn't
> help.  I do notice this message popping in the system logs, repeated
> numerous times:
>
> [drm:drm_lock_take] *ERROR* 1 holds heavyweight lock

This happens when the lock ioctl occurs when the lock is already held.
'1' is the X server, so the X server is grabbing the lock when it
already has it.

-- Gareth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
