To: "Mark Schaefer" <junk@markschaefer.org>
Cc: "'linuxppc-embedded mailing list'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: VxWorks.c ?? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Jun 2003 10:52:42 EDT."
             <00d601c330f2$489159d0$0320a8c0@onstardevserv>
Date: Thu, 12 Jun 2003 23:48:34 +0200
Message-Id: <20030612214839.0B2F9C5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Mark,

in message <00d601c330f2$489159d0$0320a8c0@onstardevserv> you wrote:
>
>     I can't find any chip that looks like it drives the USB interface.
> There are a few buffers, I believe.  I know the USB wasn't used for the
> pilot.  Only the two RS232's (one console), RS485 and ethernet were used.
> It was in a plastic box that hid the JTAG port and LED's.  I'm not really
> concerned about getting the USB working right now.

Then it either is no MPC860 CPU, or there is no USB support. Only the
MPC823 and MPC850 CPUs have a USB controller on-chip.

>     Thanks for the BDM4GDB link.  It looks like that's my best option.  I

:-)


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All a hacker needs is a tight PUSHJ, a loose pair of UUOs, and a warm
place to shift.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
