To: "Jacky Lam" <jackylam@astri.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Queston about Walnut 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 02 Oct 2003 20:01:30 +0800."
             <000e01c388dc$eb525510$0202a8c0@homevl9biy3v7e>
Date: Thu, 02 Oct 2003 14:17:28 +0200
Message-Id: <20031002121733.A2E32C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000e01c388dc$eb525510$0202a8c0@homevl9biy3v7e> you wrote:
>
> > Who gave you such (obviously wrong) instructions?
>
>         I take the example of u-boot to create the "uImage" and download it
> to the board.

Please show me which U-Boot document uses 0x00400000 as load or entry
point address so I can fix this immediately. It is WRONG  and  CANNOT
work.

> > For PowerPC systems, both  Load  Address  and  Entry  Point  must  be
> > specified as 0.
>
>         I have tried 0 before. But I get an exception in return. Could you
> kindly give me some instructions how to run a kernel on this board?

Please start by giving a precise description of  what  you  did.  and
which error messages you got.

You "get an exception" - when? When running "mkimage"?  When  booting
the kernel? Which sort of exception? What is the exact error message?
Please include a complete log of your actions and all output.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Totally illogical, there was no chance.
	-- Spock, "The Galileo Seven", stardate 2822.3

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
