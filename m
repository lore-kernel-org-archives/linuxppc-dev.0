Message-ID: <39058023.39877695@relog.ch>
Date: Tue, 25 Apr 2000 13:23:15 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree 4.0 dual monitor on AGP G4
References: <200004240616.XAA02709@pop3.ucdavis.edu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"W. Taylor Holliday" wrote:

> Has anyone tried tried to use XFree86 4.0 w/a dual monitor (dual head)
> configuration on an AGP G4? If so, what kernel are u using? Any
> not-so-obvious configuration details? I did a build of 4.0 and got it
> working on my main AGP card (it auto-detects both cards) but it crashes the
> kernel (2.2.15pre3, comes w/LinuxPPC 2K) when I modify the configuration to
> use both monitors. The kernel also crashes when I try to run it on the
> secondary card only.

Let me guess, you're using the fbdev driver for the secondary card? It needs
the BusID of the gfx chip to be specified in the Device Section or the server
will hang the machine.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
