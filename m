From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Huber <huber@alum.wpi.edu>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: random ADB lockup? (wallstreet powerbook)
Date: Fri, 5 Oct 2001 14:01:35 +0200
Message-Id: <20011005120135.14094@smtp.adsl.oleane.com>
In-Reply-To: <87k7ycno9p.fsf@mclinux.com>
References: <87k7ycno9p.fsf@mclinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Has anyone else noticed this?  It seems as though the Wallstreet I
>have experiences semi-random.  It seems like it happens some time
>after the power is removed (running off of battery).  sshing in and
>rebooting the machine seems to be the only way to get things back in
>order.
>
>I'm running 2.4.9-benh0, btw.
>
>Any ideas?  Should I try a newer kernel?

I've been reported this by several people but didn't yet find what's
going on. When the problem happen, can you enter xmon (with command-power)
and tell me if you can type anything there ? If xmon is receiving the
keystrokes, then the ADB hardware is still working properly.

Something else you can test is to disable powerbook power management from
the kernel. Then, when the problem happen, telnet into the machine and
check /proc/interrupts, tell me if the via-pmu interrupt count is
increasing when typing keys.

Regards,
Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
