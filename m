Date: Fri, 9 Apr 1999 10:16:01 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Simone Piccardi <piccardi@fi.infn.it>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC on a Motorola MVME2400
In-Reply-To: <Pine.HPP.3.96.990409140539.13413a-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.3.96.990409085312.32668A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 9 Apr 1999, Gabriel Paubert wrote:

> On Fri, 9 Apr 1999, Simone Piccardi wrote:
> 
> > Hi,
> > we buy just some day ago a Motorola MVME 2431 VME board, to use it for
> > data acquisition for a Cosmic Ray Physics experiment. I saw from
> > previous mail that someone has started LinuxPPC on this board. 
> > Could you give us some info about it? 
> > Because I'm new to this board and to LinuxPPC (I always used linux on a
> > PC machine), there is some place (or any kind of documentation)
> > describing the boot procedure (we would like to use the net booting by
> > tftp)? 
> 
> I have Linux/PPCeeee running quite well on 2600s. The corresponding
> patches are at:
> 
> 	ftp://vcorr1.iram.es/pub/linux-2.2/
> 
> in files mvme2600.generic-patch-2.2.4 and mvme2600.vme-patch-2.2.4.
> (this last one is a VME driver subsystem which I hope to officialy
> announce soon, if I can find time to do something else than answering
> e-mail).
> 
> I've not yet upgraded the various zImage (next week). They have serial
> consoles and I've used root-on-NFS with 2.2.1. 
> 
> However, the 2400 has a new chipset (Hawk) which is not yet recognized.
> If you have the technical information about it, it will be fairly easy to
> add support in the early boot code. 

Programming is the same as Falcon/Raven since it just integrates them.
The only thing that is needed is perhaps to detect it in your OpenPIC
code.  We are using a different OpenPIC patch as well as some stuff to
detect all the MCG boards and set interrupt routing properly.  Hopefully
it can get rolled in soon.

This really sucks that some of us are working from official tarballs and
some are working from vger. :-/  Though I do understand your bandwidth
constraints to the U.S.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
