To: Brian Boerner <bboerner@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: libc.so.6: cannot open shared object file: No such file or directory 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Jul 2001 06:45:20 PDT."
             <20010711134520.31259.qmail@web14202.mail.yahoo.com>
Date: Wed, 11 Jul 2001 15:58:01 +0200
Message-Id: <20010711135806.51F3F10DC8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010711134520.31259.qmail@web14202.mail.yahoo.com> you wrote:
>
> IBM Walnut 405GP. Linux is MontaVista
...
> I did see one post mentioning that you needed a
> symbolic link from the hardhat devkit to /. I was a
> bit unclear on this and didn't see anything about this
> in the mvista cdk documentation. I may have missed it,
> anything is possible at this point.
>
> Does anyone have any idea why init is being killed
> off? It complains libc.so.6 isn't being found? It's
> certainly in the ramdisk. I'm sure folks have run into
> this before.

See http://www.denx.de/tips+tricks-en.html#libpath

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"He only drinks when he gets depressed." "Why does he get depressed?"
"Sometimes it's because he hasn't had a drink."
                                     - Terry Pratchett, _Men at Arms_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
