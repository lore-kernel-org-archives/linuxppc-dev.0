To: "Kamalesh B" <kamal@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem porting ppcboot on custom board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 31 Mar 2003 22:37:00 +0530."
             <3E8875B4.B41693B7@tataelxsi.co.in>
Date: Mon, 31 Mar 2003 19:10:38 +0200
Message-Id: <20030331171043.5DB9BC587C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E8875B4.B41693B7@tataelxsi.co.in> you wrote:
>
> Problem:
> Serial port is not printing any character on the hyperterminal. I used
> CRO to see any activity on the transmit pin (TXD pin) but there is
> nothing happening.

This is off-topic on a LInux mailing list.

Also, you should not use PPCBoot for any new work.  PPCBoot  develop-
ment has been discontinued. Use U-Boot instead.

Your chances for  useful  replies  are  better  on  the  u-boot-users
mailing list.

> Iam using BDI2000 emulator just to load the ppcboot code and see the
> dump.
>
> Can u please suggest possible place where something might have gone
> wrong?

Use GDB and the BDI2000 to actually debug your code. You got a  great
tool, use it's capabilities.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It's when they say 2 + 2 = 5 that I begin to argue."    - Eric Pepke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
