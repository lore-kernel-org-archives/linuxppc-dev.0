Date: Thu, 5 Dec 2002 12:17:33 -0700
From: Matt Porter <porter@cox.net>
To: Stefano Bodini <s.bodini@comcast.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Frozen ! any idea ?
Message-ID: <20021205121733.A14807@home.com>
References: <5.1.0.14.0.20021205132823.00a3aac0@pop3.norton.antivirus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.0.20021205132823.00a3aac0@pop3.norton.antivirus>; from s.bodini@comcast.net on Thu, Dec 05, 2002 at 01:28:31PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 05, 2002 at 01:28:31PM -0500, Stefano Bodini wrote:
> In order to try to debug something I enabled the KDGB in the kernel
> (following the instructions on the MontaVista documentation).
>
> I recompiled the kernel, no errors .. but when I try to load and start it :
>
> [Go 00400000]
> loaded at: 00410000 004A81F4
> relocated to: 00400000 004981F4
> board data at: 00495128 00495144
> relocated to: 004052C4 004052E0
> zimage at: 00405960 004945AA
> avail ram: 00499000 01000000
>
> Linux/PPC load: root=/dev/nfs rw ip=auto
> Uncompressing Linux...done.
> Now booting the kernel
>
> That's it.
> Stops. No warning, no errors .. just stops.
> I'm sure this is not a minicom problem this time ... any ideas ?

There is an early default breakpoint set when you enable KGDB on
PPC.  You've hit it and need to be communicating with the in-kernel
stub to continue.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
