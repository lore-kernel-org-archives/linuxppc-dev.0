To: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
Cc: "li" <slowforce@21cn.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST sbc8260 boot debug 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 07 Nov 2003 15:11:29 MST."
             <8039970AF146314597457D3B51A68B382E042D@cossmgmbx02.email.corp.tld>
Date: Fri, 07 Nov 2003 23:25:10 +0100
Message-Id: <20031107222515.58600C5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <8039970AF146314597457D3B51A68B382E042D@cossmgmbx02.email.corp.tld> you wrote:
>
> Wolfgang is sleeping right now so I'll try to recreate his standard response...

Ooops?? Seems some parts of my body are actually quite  active  while
I'm asleeep :-)

I would have replied to this message, too, but it did not arrive here
yet.


But thanks for the nice summary.


> From: li [mailto:slowforce@21cn.com]
> Sent: Friday, November 07, 2003 11:49 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: EST sbc8260 boot debug


> > I have an EST sbc8260 board to boot. After connecting the BDI2000
> > with the board, and power on, everything seems ok. In the config file
> > for sbc8260, BR0 is set to 0xFE000801. Then, i modified ppcboot-1.1.6
> > for mpc8260, change the textbase from 0x40000000(flash address) to
> > 0x200000(sdram address) and also the FLASH base addr is set
> > to 0x200000.

I have just one question: why did you  not  simply  use  the  PPCboot
configuration  as  is?  It has been tested and is running fine on the
sbc8260 board _without_ modifications.

> > Is there any problem with my procdure?

Yes. You are meddeling with code which you'd better not touch.

> > PS: there is much switchs and JPs on the board, can anyone give an
> > proper setting for them under ppcboot environment?

Use the default settings.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A metaphor is like a simile.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
