Date: Mon, 21 Jan 2002 18:39:21 +0100
Subject: Re: Kernel 2.4.x video problems
From: Chris Boot <bootc@mac.com>
To: <benh@kernel.crashing.org>,
	LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>,
	YellowDog Devel <yellowdog-devel@lists.yellowdoglinux.com>
Message-ID: <B87210D9.C46%bootc@mac.com>
In-Reply-To: <20020121164058.7246@mailhost.mipsys.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

>> I've got a few questions pertaining to video in recent kernels (2.4.x, x >=
>> 10) on both an iMac DV SE/500 (Summer 2000, ATI Rage 128 Pro) and a G4 Dual
>> 533 (ATI Radeon).
>>
>> First of all, I can only boot the iMac using the novideo kernel argument.
>> If I attempt to use video=aty128fb with or without any vmode parameters, the
>> screen just remains black.  I can type blindly and reboot, and got a dmesg.
>> Nothing out of the ordinary.  If there are any ways of getting verbose
>> messages from the kernel or the driver itself, I would be rather grateful.
>>
>> Second, the G4/533 works fine with no arguments, but it remains in 640x480,
>> 8-bit color.  As soon as I try to get some accelerated video using the
>> Radeon FB driver, the screen remains blank as in the iMac.  A dmesg this
>> time does in fact yield a message: "radeonfb: could not claim FB region" or
>> something similar (not by the machine at the moment).  Anyone know what's
>> causing this?
>
> for radeon, can you try with a recent 2.4.18pre4 ? It should work
> (it does for me actually). You should probably get XFree 4.2.0 to fully
> benefit from accel though.

Thanks, I'll give it a spin when I get my hands on that G4 again.  The
problem is that it's a friend's computer and he's away for a few weeks now,
so it won't be until about three weeks time if even that.

> I'm not sure what's up with aty128fb, it should work, but you aren't
> the only one to report a problem. I'll check this out.

I've got that running in the end.  I had to use
"video=aty128fb:vmode:16,cmode:32", the modedb way didn't work.  I may even
have a "noaccel" in there, but I can't remember to be honest.  I can look
into it further if you wish, I did attach a dmesg with the aty128fb
debugging enabled to a message I sent to linux-kernel@vger.kernel.org, so
check the archives there for it.

Thanks,

--
Chris Boot
bootc@mac.com

"Use the source, Luke." - Obi-Wan Gnuobi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
