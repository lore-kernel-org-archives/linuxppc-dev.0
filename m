Return-Path: <rbrito@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 319D8DDE05
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Aug 2007 12:37:17 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so130620anc
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 19:37:16 -0700 (PDT)
Message-ID: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
Date: Sat, 25 Aug 2007 23:37:16 -0300
From: "=?ISO-8859-1?Q?Rog=E9rio_Brito?=" <rbrito@gmail.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org
Subject: Sleep problems with kernels >= 2.6.21 on powerpc
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

Unfortunately, it seems that kernels later than 2.6.21 have problems
letting my powerpc iBook (G3 processor) going to sleep (suspend to
ram).

The userland that I am using is a Debian testing (lenny) and the
default kernel that comes with it is 2.6.22, with some patches applied
and pbbuttonsd (as the daemon for making the machine sleep).

With kernel 2.6.21, from Debian (and other earlier kernels), the
symptoms that I see when I press the power button is that the machine
goes to sleep and the led that indicates that the machine is sleeping
is blinking normally.

If I, on the other hand, use Debian's kernel 2.6.22 or compile my own
kernel with just the necessary parts for my work (version 2.6.23-rc3
taken from kernel.org), then I can't make the machine sleep: when I
press the button, it acts like if I had, in sequence, pressed anything
to wake it up (say, like pressing shift).

I have already grabbed Linus's git tree and I am willing to do some
cycles of "git bisect" to discover the point where it stopped working.

I just thought that others may have seen such behaviour before or, if
not, that being informative about what I see is of use for debugging
this.

I would also appreciate any guidance on this as I wish kernel 2.6.23
to be working again on powerpc machines.

Please, if any tests are required, don't hesitate to ask me and I will
try to whatever is needed to restore the correct behaviour of sleep
with the Linux kernel.

I have copied mailing lists that I think that are relevant. If they
aren't, then please let me know. I would also appreciate if I were
kept on carbon copies as I am only subscribed to debian-powerpc at the
moment.


Regards, Rog=E9rio Brito.

P.S.: It unfortunately doesn't matter if I switch to a console or if I
am in X when I press the power button with recent kernels.
