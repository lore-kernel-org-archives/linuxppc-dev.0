To: Jeff Stevens <jsteve17@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC855T SMC1 2.4.22 Kernel Patch 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 17 Nov 2003 12:40:51 PST."
             <20031117204051.9515.qmail@web41407.mail.yahoo.com>
Date: Mon, 17 Nov 2003 21:57:31 +0100
Message-Id: <20031117205736.A35A6C5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20031117204051.9515.qmail@web41407.mail.yahoo.com> you wrote:
>
>    I am currently running ELDK 2.1.0 with the 2.4.4
> kernel, and am in the process of upgrading to the
> 2.4.22 kernel.  I have the new kernel compiled but
> after it uncompresses the kernel, nothing else is
> printed to the screen.  I read on the board that there
> is a kernel patch to enable the console on SMC1.  Does

Console on SMC1 is standard. About 99% of all boards use it. No patch needed.

Did you change your boot loader to pass the clock frequencies in Hz?
See http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The question of whether a computer can think is no more  interesting
than the question of whether a submarine can swim"
                                                - Edsgar W.  Dijkstra

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
