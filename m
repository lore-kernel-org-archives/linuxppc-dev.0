Message-ID: <B164B53F5BD6D511888D009027732E1A024A20@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: BDI2000 breakpoints in dynamically loaded modules
Date: Wed, 23 Jan 2002 12:13:06 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all

I am using BDI2000 to debug dynamically loaded module under Linux. When I
put a breakpoint, it never goes off, but code does execute.

At the moment the only 8260 board we have is used 100% of the time, so I do
not have much chance to do any investigation.
I'll describe what I do, may be this will help.

I load the moule under Linux and then use "add-symbol-file" command. This
allows me to view the source of my module. Then I put a breakpoint either
through IDE (DDD) or from GDB prompt. Breakpoint appears in DDD, but never
goes off. All memory translation is working.

I can not remember if it worked before, I only briefly tried modules while
ago. I recently upgraded DDD and BDI2000 firmware to the latest versions.
May be this caused it?

Any ideas are appreciated.,

Thanks,

Rudolf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
