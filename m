Message-Id: <200110042105.QAA14178@lists.linuxppc.org>
From: "Boerner, Brian" <bmb@pirus.com>
To: "'Peter Desnoyers'" <pdesnoyers@chinook.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: GDB + VisionICE?
Date: Thu, 4 Oct 2001 17:09:46 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I would contact your wrs fae. I've heard through the grapevine that some
beta firmware exists (it may be released firmware now) that supports the
MMU. I couldn't find it in my mail but it was something like:
MMU=LINUX

It might be worth exploring. I've also had good luck with the AMC PowerTAP
product as well. But that's neither here nor there.

-bmb


>-----Original Message-----
>From: Peter Desnoyers [mailto:pdesnoyers@chinook.com]
>Sent: Wednesday, October 03, 2001 12:21 PM
>To: linuxppc-embedded@lists.linuxppc.org
>Subject: GDB + VisionICE?
>
>
>
>[this is a resend - I sent it with an incorrect from: address, and it
>didn't make it to the list]
>
>Has anyone configured GDB to work with a VisionICE II for a powerpc
>target?It looks like the remote-est target is close, but only works
>for m68k targets.  It might not be much work to adapt it for powerpc,
>which leads to the second question:
>
>Is this a pointless exercise due to the lack of VisionICE support for
>the
>MMU, or would it be worthwhile?
>
>Thanks,
>--
>.....................................................................
> Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
> Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
> 100 Hayden Ave, Lexington MA 02421
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
