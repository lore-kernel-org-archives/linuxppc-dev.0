To: Magnus Damm <damm@opensource.se>
Cc: Leonard Ye <leonard_ye@ylez.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel support of MPC8XX series 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 02 Apr 2001 11:39:56 +0200."
             <3AC848EC.92161602@opensource.se>
Date: Mon, 02 Apr 2001 12:06:40 +0200
Message-Id: <20010402100645.DFCD728826@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3AC848EC.92161602@opensource.se> you wrote:
>
> > For us, the majority  of  devices  are  memory  cards  like  SanDisk,
> > CompactFlash  or  IDE  harddisk  adapters.  On  one  side, the PCMCIA
> > package is a lot of overkill here; on the other  side  it  cannot  be
> > used  when  you  want to boot from such a device.
>
> Not really true.
> It _is_ possible to boot with the PCMCIA package, it's just a bit
> harder.
> Use an initrd with a scaled-down PCMCIA package to solve it.

And where do you load this initrd image from?

I am talking about systems that don't have  any  (significant)  flash
onboard.  For  instance,  we have such a setup running on boards with
just 512 kB EPROM (right, EPROM, not flash).  We  have  to  load  the
kernel  and  anything  else  over the PCMCIA interface. I don't see a
ways how this can be done with the normal PCMCIA package.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The easiest way to figure the cost of living is to take  your  income
and add ten percent.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
