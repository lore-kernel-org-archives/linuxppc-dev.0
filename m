To: "Navin Boppuri" <navin.boppuri@newisys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Back to the Basics with gcc 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 10 May 2001 18:39:37 CDT."
             <2C51E4D0FC94B24DA9B1C4628956F79022AEA4@aten.ad.newisys.com>
Date: Fri, 11 May 2001 01:50:00 +0200
Message-Id: <20010510235006.536932814D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <2C51E4D0FC94B24DA9B1C4628956F79022AEA4@aten.ad.newisys.com> you wrote:
>
> I would like to run a simple c program on my embedded board with mpc860.
> All I would like to do is compile the code, load it into some blank ram
> location and say "go" at that location. I have a BDI debugger running
> and can successfully load a binary into some mem location. But how
> should I compile this program and generate the required binary?

See the code and Makefile in the "examples" directory of the  PPCBoot
sources. You have PPCBoot running anyway, right?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
We fight only when there is no other choice. We prefer  the  ways  of
peaceful contact.
	-- Kirk, "Spectre of the Gun", stardate 4385.3

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
