Message-ID: <20020621194234.37274.qmail@web21103.mail.yahoo.com>
Date: Fri, 21 Jun 2002 12:42:34 -0700 (PDT)
From: Tim Lai <laitingwai@yahoo.com>
Subject: Re: Can I run linux without a file system?
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <200206211835.g5LIZDL01282@hofr.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am interested in both input/output operation
on the console. If I just set CONFIG_SERIAL_CONSOLE,
will I be able read input from the console?
The main application will be started from init(),
and the application will need to read and write
to the console. Are there are method to communicate
to the serial port other than open("/dev/ttyS0")?


>
> You don't need a filesystem to get output on the
> serial console
> you just need to enable the console with
> CONFIG_SERIAL_CONSOLE=y
> in your kernel configuration (atleast for mpc860
> that all)
> but you will have a hard time producing much more
> than a blinking
> cursor if you boot a Linux kernel and have no
> application that
> it then can run on the root-filesystem - what would
> be the point
> of such a setup - 1MB kernel code for a blinking
> cursor on a
> serial port seems expensive.
>
> hofrat


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
