To: Michael Habermann <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU and BDI2000 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 14 Sep 2001 17:58:29 +0800."
             <5.1.0.14.0.20010914174808.026db880@pop.gmx.de>
Date: Fri, 14 Sep 2001 13:29:48 +0200
Message-Id: <20010914112953.26B7C10099@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <5.1.0.14.0.20010914174808.026db880@pop.gmx.de> you wrote:
>
> I've not found a BDI newsgroup or FAQ so I'm sorry

Maybe we should start a mailing list.

> But I get problems debugging variables. The BDI often prints:
> '*** MMU: address translation for 0xC100B288 failed',
...
> [TARGET]
> CPUTYPE	    MPC800
> CPUCLOCK    25000000    ;the CPU clock rate after processing the init list
> BDIMODE     AGENT       ;the BDI working mode (LOADONLY | AGENT)
> BREAKMODE   HARD        ;SOFT or HARD, HARD uses PPC hardware breakpoints
> MMU XLAT

Are you using latest BDI2000 firmware?

I'm missing a PTBASE definition in this section  -  without  it  only
default  translation  is  enabled.  See  the  BDI2000  user's manual,
Section "3.2.2 Part [TARGET]" (Entries "MMU XLAT  [kb]"  and  "PTBASE
addr") and Section "3.3.4 Embedded Linux MMU Support".

Please note that the 2.4.4 kernel on our  FTP  server  does  not  yet
include  the  automatic  update  of  the  BDI  page table information
structure mentioned in the BDI2000 manual. We will have this  in  the
next version (as soon as it's running stable).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Is a computer language with goto's totally Wirth-less?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
