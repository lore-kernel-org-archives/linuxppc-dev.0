Date: Mon, 16 Jun 2003 11:27:08 -0400
Message-Id: <200306161527.h5GFR8L20194@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: Stephan.Linke@epygi.de
Cc: rshen@udtech.com.cn, linuxppc-embedded@lists.linuxppc.org
In-reply-to: <FCEAKDJJAPHPLJFINDAJIEKCDCAA.Stephan.Linke@epygi.de>
Subject: Re: debugging using BDI2000 on MPC860
References: <FCEAKDJJAPHPLJFINDAJIEKCDCAA.Stephan.Linke@epygi.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I don't know how to interprete this but it always stops with the following status:
>
>    Target state      : debug mode
>    Debug entry cause : machine check interrupt
>    Current PC        : 0x00000100
>    Data  address     : 0x00000000
>    DSISR value       : 0x00000000

>From this you can see that the BDI stopped processing at address 0x100
(Current PC) because of a machine check (Debug entry cause).  You
should check the values of srr0/srr1, etc to determine why it took the
machine check.

--
Peter Barada                             Peter.Barada@motorola.com
Wizard                                   781-852-2768 (direct)
WaveMark Solutions(A Motorola Company)   781-270-0193 (fax)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
