Date: Wed, 11 Oct 2000 20:43:28 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
Subject: Re: dual head r128
To: Josh Huber <huber@mclx.com>
Cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Message-id: <39E4B4D0.FA62D929@student.ethz.ch>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <20001011141722.A1437@missioncriticallinux.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Josh Huber wrote:
>
> Anyone got dual head r128 up and running on ppc?  I've got a dual G4
> system here (running a UP kernel for now), with the shipped AGP r128
> card, and another PCI (pc, no fcode) r128 card.
>
> The relevant information is attached, lspci -vv, XF86Config, and the
> log of the failed X startup.  X works with just the AGP card, as
> expected.
>
> Of note is the:
> c000:00b9: 63 ILLEGAL X86 OPCODE!
>
> line in x.log, when trying to run int10 on the secondary card.

I don't think that's the cause, it fails much later.

Have you built X yourself? If yes, you need patches from Ani Joshi. The memory
and clock values it probes are obviously bogus.

Wait a minute, I see you are using debs, which should contain Ani's stuff.
Does aty128fb work on the second card? If yes, try Option "UseFBDev".


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
