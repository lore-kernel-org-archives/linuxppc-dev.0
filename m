To: "XOL" <xol@mail.ru>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Re[2]: How to change Bus speed for MPC8xx CPU 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 18 May 2003 14:35:27 +0400."
             <E19HLVn-000N0u-00.xol-mail-ru@f20.mail.ru>
Date: Sun, 18 May 2003 12:43:00 +0200
Message-Id: <20030518104305.DE7E8C6162@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <E19HLVn-000N0u-00.xol-mail-ru@f20.mail.ru> you wrote:
>
> As far as I understand there is a bootloader provided by board
> manufacturer this is something like BIOS in desktop pc.
> And there should be part of the kernel running before
> the kernel starts. So which one of them do the job with
> clocks? Or probably both of them.

Normally the clocks are set in the bootloader only.

Linux does not change these parameters.

> And there the kernel loader sources are located under
> /usr/src/linux tree. I would like to put my patch inside and paly
> with it.

You wrote:

> My board is runnig from external clock of 10M and boot monitor
> has parameter called mulitplier which is equal to 10.

So it seems there is  no  patch  needed  at  all.  Just  change  this
"multiplier" parameter.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No one can guarantee the actions of another.
	-- Spock, "Day of the Dove", stardate unknown

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
