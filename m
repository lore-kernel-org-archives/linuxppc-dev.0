Message-ID: <38ED748E.A2E7508A@uncc.edu>
Date: Fri, 07 Apr 2000 01:39:26 -0400
From: "William H. Schultz" <whschult@uncc.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, Brendan.Simon@ctam.com.au
Subject: Re: linux-powerpc: booting from zip disk ?
References: <200004070459.XAA07499@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Date: Fri, 07 Apr 2000 11:19:32 +1000
> From: Brendan J Simon <Brendan.Simon@ctam.com.au>
> Subject: linux-powerpc: booting from zip disk ?
>
> Does any one know if I can boot linux from a zip disk on a PowerMac G4 ?
>
> Ethan Benson mailed me a script to produce a CD image so I can boot from
> it and install Debian, but unfortunately I don't have access to a CD
> burner anymore.
>
> So can it be done ?
> Do I need to fool around in Open Firmware ?
> If so what do I need to do ?
>
> Thanks,
> Brendan Simon.

You sure can.  Format your zip disk to HFS (not HFS+).  Set up under
Linux that this will be  mounted at /boot.  From this point, you have
several options.  Most people in your situation would use yaboot.  There
is also miboot, but I don't know if that will boot a G4.

Both of those are available at:

http://www.linuxppc.com/updates/

(they are on the right of the screen)



Hank

ps  I assume you are somewhat familiar with what goes in /boot

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
