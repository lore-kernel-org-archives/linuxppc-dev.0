From: benh@kernel.crashing.org
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>,
	YellowDog Devel <yellowdog-devel@lists.yellowdoglinux.com>,
	Chris Boot <bootc@mac.com>
Subject: Re: Kernel 2.4.x video problems
Date: Mon, 21 Jan 2002 17:40:58 +0100
Message-Id: <20020121164058.7246@mailhost.mipsys.com>
In-Reply-To: <B868D512.2EE%bootc@mac.com>
References: <B868D512.2EE%bootc@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hi all,
>
>I've got a few questions pertaining to video in recent kernels (2.4.x, x >=
>10) on both an iMac DV SE/500 (Summer 2000, ATI Rage 128 Pro) and a G4 Dual
>533 (ATI Radeon).
>
>First of all, I can only boot the iMac using the novideo kernel argument.
>If I attempt to use video=aty128fb with or without any vmode parameters, the
>screen just remains black.  I can type blindly and reboot, and got a dmesg.
>Nothing out of the ordinary.  If there are any ways of getting verbose
>messages from the kernel or the driver itself, I would be rather grateful.
>
>Second, the G4/533 works fine with no arguments, but it remains in 640x480,
>8-bit color.  As soon as I try to get some accelerated video using the
>Radeon FB driver, the screen remains blank as in the iMac.  A dmesg this
>time does in fact yield a message: "radeonfb: could not claim FB region" or
>something similar (not by the machine at the moment).  Anyone know what's
>causing this?

for radeon, can you try with a recent 2.4.18pre4 ? It should work
(it does for me actually). You should probably get XFree 4.2.0 to fully
benefit from accel though.

I'm not sure what's up with aty128fb, it should work, but you aren't
the only one to report a problem. I'll check this out.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
