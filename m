Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: CONFIG_SERIAL_TEXT_DEBUG causes exception
Date: Wed, 19 Mar 2003 12:47:33 -0500
Message-ID: <EGEGIJHKDKJGAJMGIDPNEEMMCJAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:

I have a custom PPC405GPr board that I have successfully ported u-boot to.

I am now at the stage of trying to bring Linux up on the board.

I have CONFIG_SERIAL_TEXT_DEBUG defined for the kernel that I am trying to
bring up.  I would like to have this option so I can trace through the
kernel.
The comments in ppc4xx_setup.c in the function serial_putc indicate that as
long
as the firmware (in my case u-boot) has been initialized properly, then this
function
should work.  I have verified the addresses that the function is trying to
write to
and they are correct.  However, when serial_putc calls the first readb, I
get an
exception.

Can someone please provide some pointers as to what might be wrong?

Thanks

Jerry Walden


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
