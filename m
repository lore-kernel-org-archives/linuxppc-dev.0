To: Peter Desnoyers <pdesnoyers@chinook.com>
Cc: GOTZON ASTONDOA <gastondoa@fagorautomation.es>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: IDE on PCMCIA error 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 26 Oct 2001 10:42:00 EDT."
             <3BD97638.4115F7A9@chinook.com>
Date: Fri, 26 Oct 2001 17:02:51 +0200
Message-Id: <20011026150256.A5EF010CDB@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BD97638.4115F7A9@chinook.com> you wrote:
>
> >Also, Linux relies on the  initialization  of
> > the PCMCIA interface performed by PPCBoot.
>
> It depends.  The m8xx driver in the pcmcia-cs tree seems to initialize
> everything except the card voltages.

Right, that's when you use the CS package which is a bit of  overkill
for  an  embedded  system,  especially  when you want to put the root
filesystem on the flash card.

I was speaking about the "simple" IDE interface which  you  get  with
the  CONFIG_IDE_8xx_PCCARD  config  option  (plus  one of 8xx_PCCARD,
8xx_DIRECT, or EXT_DIRECT). In this  case,  Linux  reads  the  memory
mapping from the PCMCIA controller registers.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Only in our dreams we are free. The rest of the time we neeed  wages.
                                    - Terry Pratchett, _Wyrd Sisters_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
