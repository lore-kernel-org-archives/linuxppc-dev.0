Message-ID: <3B97984C.CCE09FE7@mvista.com>
Date: Thu, 06 Sep 2001 10:37:48 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Navin Boppuri <navin.boppuri@newisys.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ctrl-C does not work
References: <3A494DE356A49A40B37442E1E0D9F3B506343E@ptah.ad.newisys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Navin Boppuri wrote:
>
> Hello everyone,
>
> Ctrl-C does on work on my serial console when I use the sample file
> system from Hardhat 1.0 toolkit. It , however, works with the Hardhat
> 1.2 toolkit sample file system. I am using the same kernel to test both
> the file systems. What could be different between these two file
> systems?
>
> Thank you,
> Navin

Actually control-c should _NOT_ be working on Cross Dev Kit 1.0, or
1.2.  If it does work in one you are lucky.  There is a problem with the
way the serial consoles are started on CDK 1.0 and 1.2, it was left up
to the serial driver to turn on or off the control-c activation.

Under HHL 2.0, this problem has been resolved by using getty and login
to start a serial connection.  login has a patch that ensures that the
control-c stuff is enabled.

I would highly recommend that you move forward to HHL 2.0 if you can, it
has a lot of these minor annoyances fixed.

--Mark Hatle
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
