MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: linux-2.4.18 & copy-back cache mode 
Date: Tue, 12 Mar 2002 09:58:01 -0600
Message-ID: <D3A72C5007329A4F991C0DD87202259F096A9F@sekhmet.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Wojciech Kromer" <krom@dgt-lab.com.pl>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You will have to whip up a set of UPM words specific for you SDRAM. Wolfgang told me this a million times before I finally got my SDRAM working. Look at your SDRAM datasheet and you should be able to figure out the timing.

Also, there is utility from Motorola `MCUinit 3.1` that has a GUI interface to whip out all the timing for you memory controller. Search for it in google and you should be able to download it.

Navin.


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
