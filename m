From: Der Herr Hofrat <der.herr@mail.hofr.at>
Message-Id: <200301091921.h09JLLP03384@hofr.at>
Subject: Re: Calling Application
In-Reply-To: <001b01c2b810$7ec76720$370da8c0@aman> from Aman at "Jan 10, 2003
 00:24:10 am"
To: Aman <aman@mistralsoftware.com>
Date: Thu, 9 Jan 2003 20:21:21 +0100 (CET)
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Hi All
>
> This might be a basic question. I have build the linux kernel for custom
> board which has PPC 440GP as its processor. I have also build my
> application. Now I wanted to call my application after the kernel boots up.
> Can you tell me where I hv to call my application.
>
pass the kernel a init=/bin/my_app at the boot-prompt if you realy want only
that one app to run, otherwise use the inittab or one of the resource scripts
in /etc/rc.d to launch your application.

hofrat

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
