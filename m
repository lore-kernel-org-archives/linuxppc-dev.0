To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: CAN and MPC855T/860T 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 26 Oct 2001 09:49:31 +0200."
             <3BD9158B.D3067C74@imc-berlin.de>
Date: Fri, 26 Oct 2001 10:06:23 +0200
Message-Id: <20011026080628.D625310CDA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BD9158B.D3067C74@imc-berlin.de> you wrote:
>
> I know that TQ Components integrated two intel 82527 on their TQMs /
> STK8xxL.
> But I couldn't find any sources supporting them by now.

You didn't ask before...

> Could you please give me some pointers to driver source code.

Actually, the driver source code is just one part of the issue.  What
are you going to do with it?

IMHO there are two Open Source projects that look interesting:

   1. http://home.wanadoo.nl/arnaud/
   2. http://www.esstin.uhp-nancy.fr/~tissered/CanFestival/

The first provides generic CAN support  for  a  couple  of  controler
boards  and chips. We have a (preliminary version of) a device driver
for it running on the TQ modules.

The second project implements (parts of)  the  CANopen  protocol  and
integrates  with  RTLinux. However, it is a non-trivial job to get it
running on the TQ hardware, and I'm not sure if the  effort  is  well
invested.


See also:

	http://www.microcontrol.net/CANpie/

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Of course there's no reason for it, it's just our policy.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
