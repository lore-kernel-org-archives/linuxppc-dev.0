Subject: Re: ATM switching in MPC8260
From: James Campbell <jcampbell@omnigon.com>
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <B164B53F5BD6D511888D009027732E1A0249AA@ntserver.act.domain>
References: <B164B53F5BD6D511888D009027732E1A0249AA@ntserver.act.domain>
Content-Type: text/plain
Date: 05 Dec 2001 08:18:37 -0800
Message-Id: <1007569117.1270.2.camel@mordja.omnigon.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Its techincally possible.  We have two versions of our 8260/PMC-Sierra
SAR board.  One that directly talks to the control lines of the PMC
chip, and one that uses full 8260 atm support under linux (ported from
the 860 SAR).  Both work well.

Cheers,

James Campbell


On Tue, 2001-12-04 at 20:30, Rudolf Ladyzhenskii wrote:
>
> Hi, all
>
> I have to do some ATM traffic switching using MPC8260. Preferable without
> processing data by the 603 core.
> AAL2 microcode can do that for AAL2
> MPC8260 manual says that it is possible to do it on AAL0
>
> Does anyone know if this is possible for AAL5?
>
> Thanks,
>
> /************************/
> Rudolf Ladyzhenskii
> DSP Engineer
> Advanced Communication Technologies
> ph.  +61 3 8080 8215
> fax. +61 3 9672 8800
> Level 9, 190 Queen Street,
> Melbourne, 3000
> Australia
> /***********************/
>
>
>
--
James Campbell          -|-   Embedded Systems Engineer
jcampbell@omnigon.com   -|-     Omnigon International
pgp:  C323 70EC 6E2D 61CB 4692 14E4 4F79 3530 D49F A9CE
work: +1.760.804.8884 x 332       cell: +1.760.492.1176
--
"Computer games don't affect kids; I mean if Pac-Man
affected us as kids, we'd all be running around darkened
rooms, munching magic pills and listening to repetitive
electronic music."
         -Kristian Wilson, Nintendo, Inc. 1989


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
