Message-Id: <200101300049.f0U0n3G05511@denx.local.net>
To: Timothy Ritchey <tritchey@vacuumgenesis.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860T FEC 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 29 Jan 2001 15:11:36 PST."
             <3A75F8A8.64ADB0C@vacuumgenesis.com>
Date: Tue, 30 Jan 2001 01:49:03 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Tim,

in message <3A75F8A8.64ADB0C@vacuumgenesis.com> you wrote:
>
> Has anyone had any luck with the 860T FEC driver in the 2.4 kernel (I am
> using the 01/13/01 snapshot from FSMLabs). It is certainly not working
> out-of-the-box as it were. For example, it tries calling mii_queue with

No, it ain't.

> the ethernet device) but it is never called. I cannot see how this code
> was ever working properly. Is anyone running it that can refute this? I

I think you are right. This code cannot work, never could.

But the good news is that I have a working version of the FEC driver;
see our modified kernel sources in
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/,
or the patch at
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/patches/patch.8xx_misc
(and the README for it in
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/patches/README.8xx_misc
).

BTW: I've sent all these patches to Dan and Cort and Ben, so  I  hope
at least part of it will make it in the official sources.

> have made some changes that seem to get it halfway there, but am not
> getting any transmit interrupts yet (I am getting receive and mii
> interrupts).

It's working for me in several configurations.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Visit us at Embedded Systems: Feb 14-16 2001, Nuremberg, Halle 12/K01
(with TQ Components); our presentation "Starke Zwerge: Embedded Linux
auf PowerPC-Systemen" on Thursday, Feb 15 2001, 13:30 Forum Halle 11.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
