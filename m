Message-ID: <20000327175419.2957.qmail@www0s.netaddress.usa.net>
Date: 27 Mar 00 10:54:19 MST
From: Robert Shaw <rshawppc@netscape.net>
To: Gabriel Ricard <g_ricard@yahoo.com>, Robert Shaw <rshawppc@netscape.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [Re: PCI address collisions on 2.3.x kernels?]
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Ricard <g_ricard@yahoo.com> wrote:

> Did you copy your old .config to the new kernel src
> dir and run make oldconfig? Or just choose the same
> options? Are you sure you had the correct IDE support
> built in?

Initially, that's what I tried. Since then I have just gone in and made sure I
had the same step selected that I did in the 2.2.15pre14 kernel that works for
me. I'm positive I had the IDE support set properly (as compared to my working
2.2.15 kernel). Unless there is some new option I don't know I need.

Also, it appears to find my SCSI drive and CD-RW (SCSI) drive just fine, so I
would expect any non-IDE systems would boot. I have not tried booting off the
SCSI drive I have, but I can try that tonight and see if it gets any further.









-Robert
 mailto:rshaw@linuxppc.org
 icq:45688313
 http://www.linuxppc.org/BlueG3/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
