Message-ID: <3DEF9E82.7A1E9254@synergymicro.com>
Date: Thu, 05 Dec 2002 10:44:18 -0800
From: Dave Wilhardt <wilhardt@synergymicro.com>
Reply-To: wilhardt@synergymicro.com
MIME-Version: 1.0
To: Stefano Bodini <s.bodini@comcast.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Frozen ! any idea ?
References: <5.1.0.14.0.20021205132823.00a3aac0@pop3.norton.antivirus>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You might try disabling minicom's hardware and software flow control.  Been
there...

- Dave

Stefano Bodini wrote:

> Hi all ... just my little testimonial about the problem.
> Well, Linux and the little board were always working.
> The freeze actually was minicom on the host, used to "speak" to the console !!!
> I don't know why minicom freeze after 1 minute but sure I will not use it
> anymore !
>
> So Linux is working well on the board.
>
> Now I have to solve the problem to have the kernel running if compiled with
> the gdbserver option enabled.
>
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
>
> Many many thanks in advance
>
> C'ya
>         Steve
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
