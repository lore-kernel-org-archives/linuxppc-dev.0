To: "Walser, Martin" <mwalser@harris.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: segmentation fault when using "signal" 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 Apr 2002 01:04:58 EDT."
             <8D4C69676E66D511A1CB00508BBBB1921BCF21@ranmx1.ran.harris.com>
Date: Tue, 23 Apr 2002 00:00:13 +0200
Message-Id: <20020422220018.785C7FF61@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <8D4C69676E66D511A1CB00508BBBB1921BCF21@ranmx1.ran.harris.com> you wrote:
>
> I've a probelm using the signal function.
> I'm using Kernel 2.4.4 from Denx. When I install a signalhandler for SIGCHLD, I
> get an segmentation fault, when the child process is finished.
>
> I've found out that this happens, when the function installed by signal returns.
>
> Any ideas?

Bad cross tools, header files, and/or libraries...

Works here...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Any technology distinguishable from magic is insufficiently advanced.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
