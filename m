To: ibm405gp <ibm405.linux@laposte.net>
Cc: Scott Anderson <scott_anderson@mvista.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ?Loading and debugging a linux kernel on a walnut board with a BDI2000 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 03 Jul 2001 16:25:28 -0000."
             <3B41F1F8.C88E0460@laposte.net>
Date: Tue, 03 Jul 2001 16:27:32 +0200
Message-Id: <20010703142737.CC3B510E1F@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3B41F1F8.C88E0460@laposte.net> you wrote:
>
> but the boot sequence fails, the zImage is not extracted
> In arch/ppc/boot/tree/main.c, i put some debug printf, and i have
> "Memcopy Done " instead of "gunzip done"
> What means the condition "if (im[0] == 0x1f && im[1] == 0x8b) " ?

Seems it checks for the magic number which  gzip  inserts  into  it's
compressed files.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If you hear an onion ring, answer it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
