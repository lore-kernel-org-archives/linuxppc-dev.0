To: Wojciech Kromer <krom@dgt-lab.com.pl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.4.18 & copy-back cache mode 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 12 Mar 2002 08:08:12 +0100."
             <3C8DA95C.7060402@dgt-lab.com.pl>
Date: Tue, 12 Mar 2002 10:38:16 +0100
Message-Id: <20020312093821.4D82810BF3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C8DA95C.7060402@dgt-lab.com.pl> Wojciech Kromer wrote:
>
> >Browse the PPCBoot sources;  I  added  a  configuration  for  TQM8xxL
> >modules   at   66   MHz  (cpu-bus  1:1)  recently;  also,  the  LWMON
> >configuration runs at 66 MHz 1:1.
> >
> OK, thank You. But this UPM table dosen't seem to work with my DIMM.

Probably not. The whole initialization depends  on  the  actual  chip
types; it's Micron SDRAM in our case.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
An armed society is a polite society.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
