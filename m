Message-ID: <3AEF8C19.42B979CC@cdotb.ernet.in>
Date: Wed, 02 May 2001 09:54:57 +0530
From: "N.Suresh" <nsuresh@cdotb.ernet.in>
MIME-Version: 1.0
To: guinan@bluebutton.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Booting problem on MBX board
References: <Pine.LNX.4.21.0105011146240.8926-100000@gemini.home.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jamie Guinan wrote:

> On Tue, 1 May 2001, N.Suresh wrote:
>
> > Hi,
> >
> >     I am trying to compile and MPC8xx-2.2.13 on MBX board (MBX860-005B).
> >
> >     I am able to compile and generate zImage which i am downloading thru
> >
> >     <cut>
> >
> >     EPPC-Bug>pl 20 0
> >
> >       loaded at:     00210000 0021B1D8
> >       relocated to:  00100000 0010B1D8
> >       board data at: 003F4558 003F4580
> >       relocated to:  00200100 00200128
> >       zimage at:     00216000 00271893
> >       initrd at:     00271893 00273E7D
> >       avail ram:     00274000 00400000
> >
> >       Linux/PPC load:
> >       Uncompressing Linux...done.
> >       Now booting the kernel
>
> [ Its been a while... ]
>
> That looks good so far.   The next thing you want to see is
> the Linux banner "Linux version ...".
>
> I would not change KERNELLOAD.
>
> Are you using any additional ram?  I had an additional DIMM on my
> board, and I had to hack arch/ppc/mbxboot/head.S to set up BR2/OR2
> because EPPC-Bug didn't recognize my DIMM.
>
> You should be using the Monta Vista tools.  You might want to
> compare your .config to mine,
>
>   http://www.bluebutton.com/proj/mbxlinux/dot.config
>
> Make sure you have your bootp and NFS (for root fs) servers ready when
> the board finally boots.
>
> -Jamie
>
> >
> >     </cut>
> >
> >     and the system hangs.. i tried to change the KERNELLOAD and then also
> >
> >      it is not working.
> >
> >     Any idea what's happening?
> >
> >     ( I have seen the mail archive and Jamie Guinen has told it is working
> >
> >     with EPPC-Bug).
> >
> >     thanx in advance,
> >
> >     bye
> >
> > -----------------***************************************----------------
> >                                 N.SURESH
> >                             Research Engineer,
> >                   Centre For Development of Telematics,
> >                            71/1,Sneha Complex,
> >                             Bangalore-560052
> > -----------------***************************************----------------

Hi,
    We are using MBX8xx Board with 16 Mb RAM without any DIMM.

    We  are using tools provided by Embedded Development Kit by RedHat.

    I compared your .config with mine and lots of differences are there..

    But my .config should also work, right...

    bye

--
-----------------***************************************----------------
                                N.SURESH
                            Research Engineer,
                  Centre For Development of Telematics,
                           71/1,Sneha Complex,
                            Bangalore-560052
-----------------***************************************----------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
