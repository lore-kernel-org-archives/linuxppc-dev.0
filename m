From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: partial boot progress with 2.6 kernel and MPC850 board
Date: Sun, 9 May 2004 16:49:18 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHOEODCFAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.LNX.4.58.0405090948480.22099@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Freeing unused kernel memory: 76k init
> FIFOs opened successfully.           <-- where "minit" kicks in ...
> About to start default service.
>
>   at which point it hangs, but this is where i'm using "minit" to start
> the initial services, and i should probably remove a bunch of
> non-essential services just to see if i can complete the boot process.

I still think you should modify the MachineCheck exception, without it I think
any SEGV will come out as FPU emulation exception.

>
>   i'll keep working on this and report back if anyone is interested in
> whether i finally get a full boot.

Good, I am interested to hear.

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
