Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Raven Cop 8260 Utility
From: Bruno Coudoin <bcoudoin@anfora.fr>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20020214110142.F0618109E1@denx.denx.de>
References: <20020214110142.F0618109E1@denx.denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: 14 Feb 2002 12:26:21 +0100
Message-Id: <1013686011.30549.25.camel@bruno>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


No, there is still no mmu support but it would allow us to flash
ppcboot. The Special OCD commander for MPC8260 includes the flashing
capability.

Bruno.

le jeu 14-02-2002 à 12:01, Wolfgang Denk a écrit :
> In message <1013681637.30550.21.camel@bruno> you wrote:
> >
> > Did somebody has successfully been able to use the free Special OCD
> > Commander for MPC8260 eval board from Macgraigor for their Raven COP
> > cable.
>
> Even if you could get it working, it won't take you far. Or  do  they
> have MMU support now?
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> See us @ Embedded Systems Nuremberg, Feb 19-21, Hall 12 K01 (with TQ)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
