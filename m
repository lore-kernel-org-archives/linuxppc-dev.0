Message-ID: <39871F8A.C2B1D262@student.ethz.ch>
Date: Tue, 01 Aug 2000 21:05:46 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Takashi Oe <toe@unlserve.unl.edu>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: LinuxPPC X Server
References: <20000731140748.1481@mailhost.mipsys.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> I'm working on a /dev/agpgart implementation for new machines.

Great, I'd happily beta-test and/or help, will that be in your rsync-tree or
in 2.4?

> But DRI should be already port-able using the PCI GART provided by most ATI
> chipsets.

The latest r128 DRI driver should work without AGP GART, but AFAIK PCI GART
support is only planned yet - I assume and hope it should work anyway?

> Any volunteer ?

I'll have a try. (checking out the DRI CVS tree now :)


Michel


--
Man invented language to satisfy his deep need to complain.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
