To: Ibon Gotxi Garcia <igotxi@jazzfree.com>
Cc: Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kgdb and mpc8xx (again) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "10 Mar 2003 17:42:01 GMT."
             <1047318121.29389.44.camel@muse>
Date: Mon, 10 Mar 2003 22:04:14 +0100
Message-Id: <20030310210419.8B873C58BB@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1047318121.29389.44.camel@muse> you wrote:
>
> If i run ppc-linux-gdb instead of kermit, i get
>
> 0xc0009db0 in breakpoint () at ppc-stub.c:726
>
> and the board restarts itself.
>
> I have no idea why. Maybe:
>
> 1.- It's something related with some console output (don't know if
> enabling kgdb disables all the console output in SMC1).

No.

> 2.- A watchdog timeout happens (Does the kgdb code resets the
> watchdog?).

If your watchdog has not been disabled by the boot loader,  you  have
absolutely  no  chance to debug the system using kgdb. Either disable
the watchdog, or use a BDI2000.

> 3.- Do I have to do a "set endian xxx" in ppc-linux-gdb ??? (to get that

You don't.

> I'm using the denx kernel from the cvs and ppc-linux-gdb from ELDK 2.0.2
> (on a x86 development machine)

You should use ppc_8xx-gdb as documented.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Vulcans worship peace above all.
	-- McCoy, "Return to Tomorrow", stardate 4768.3

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
