Message-ID: <3BC79786.47B0E3F4@mediaways.net>
Date: Sat, 13 Oct 2001 03:23:18 +0200
From: Christoph Ewering <Christoph.Ewering@mediaways.net>
Reply-To: Christoph.Ewering@mediaways.net
MIME-Version: 1.0
To: Ethan Benson <erbenson@alaska.net>
Cc: Debian-powerpc <debian-powerpc@lists.debian.org>,
	Linux/PPC-devel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Last call for testing: yaboot-1.3.4pre3
References: <20011012055150.B10713@plato.local.lan>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Ethan!

Maybe I missed something, but I do not run yaboot from a bootstrap-partition. I use a
bootscript and have yaboot on the same partition as MacOS 9.x and MacOS X. My
Linux-kernels are in the Systemfolder that also contains the bootscript, yaboot and yaboot.conf.

Is this boot-method not supported any more?
Cause yaboot 1.3.4pre3 can load the yaboot.conf but not the kernels (yaboot 1.3.4pre 1
could not read the yaboot.conf)

BTW. This is the first yaboot after version 1.? (well the one with this funny
penguin-picture, Ben wrote to me this is a very buggy yaboot, but it works perfectly on my
TiPB) that gets to the yaboot-prompt on my TiPB.

Bye,
	Christoph


Ethan Benson schrieb:
>
> I am going to take the resounding silence as an indication that there
> are no problems with yaboot 1.3.4pre.
>
> I plan to release 1.3.4 this weekend unless someone speaks up and
> points out some problem.
>
> pre3 is up now, one test i would like to see is netbooting by holding
> down the `n' key on bootup of a PCI G4 (not G3), these machines appear
> to netboot with dhcp rather then bootp and i want to know if yaboot
> will parse the bootpath properly.
>
> On Blue G3s when booting via the `n' key the bootpath ends up being
> enet:bootp yaboot has to throw away the bootp part to work, what i
> want to know is if dhcp versions of OF use something like enet:dhcp or
> equivilent.
>
> Simply booting yaboot via `n key' netboot will answer this question,
> if its using something like enet:dhcp yaboot will fail to locate its
> config file and print out the device path it tried, just send me that
> error message.
>
> http://master.penguinppc.org/projects/yaboot/1.3.4pre/

--
Dipl. Ing. Christoph Ewering    C & E Informationsdienste GbR
0 52 54 80 68 66 oder 0173 566 266 1
eweri@cunde.de

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
