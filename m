Message-ID: <3BDD92DF.F9714CE0@mvista.com>
Date: Mon, 29 Oct 2001 09:33:19 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: lokes@naradnetworks.com
Cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compressing S-REC ?!?!
References: <NEBBIIHKKKOGHDOKEPOMIEDGCEAA.lokes@naradnetworks.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Srinivas Loke wrote:
>
> Dan:
>
> We are trying to use the new prototype board from Embedded Planet
> (EP405) and I can't seem to install the HardHat Linux on it. Ofcourse
> I have the 1.x version of Linux and I just downloaded the HardHat 2.x
> JourneyMan but I can't seem to have any luck with this new board.
> Any clues?
> --
> Srini Loke
>
> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Dan
> Malek
> Sent: Monday, October 29, 2001 9:48 AM
> To: Sarnath Kannan
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Compressing S-REC ?!?!
>
> Sarnath Kannan wrote:
>
> > Hi All,
> >  I have the "zsrec" program that accompanies
>
> That program converts a zImage file into S-records.
> It was originally written for the Embedded Planet
> boards, and I guess has found some uses beyond that.
>
>         -- Dan
>


Use the  bits are in linuxppc_2_4_devel. MVista does not have an hhl 2.0
version out but the tools work.

Select B in "Enter (B)inary or (S)record input mode <B> " when
downloading a kernel.

-- armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
