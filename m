To: Anil Giri <anil@india.tejasnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux-2.4.18 on MPC860T -Linux kernel boot problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 12 May 2003 18:37:57 +0500."
             <1052744877.3ebf9cad5d4d8@pop-mail.india.tejasnetworks.com>
Date: Mon, 12 May 2003 15:27:53 +0200
Message-Id: <20030512132758.B86AFC6092@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Anil,

in message <1052744877.3ebf9cad5d4d8@pop-mail.india.tejasnetworks.com> you wrote:
>
> I'm trying to run a Linux kernel (2.4.18) on a Motorola MPC860T
> processor.But my kernel boot hangs in my_console_write function in uart.c
> I can't see any message on the console after "Now booting the kernel".

Can you see  any  output  in  the  log_buf  area  if  you  perform  a
post-mortem dump (using PPCBoot's "md" command) ?

> My question is, has anyone been able to boot a 2.4.18 kernel on an
> MPC860T, using PPCBoot as the boot loader ? If so, have you encountered such a
> problem ? Is there any issue with clock freq. in Hz instead of Mhz.?
> Is there any patch available for ppc?

2.4.18 usually runs perfectly fine on 8xx, assuming that you made  no
errors when porting the Linux kernel to your board.

Yes, there is an issue with clock frequencies in Hz versus MHz, which
has been documented in several places. See for example  the  "README"
and  "CHANGELOG"  files that come with the PPCBoot source (search for
"CONFIG_CLOCKS_IN_MHZ"), or see section "10. Questions  and  Answers"
of our documentation at http://www.denx.de/re/DPLG.html


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Bus error -- please leave by the rear door.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
