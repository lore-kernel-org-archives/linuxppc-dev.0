Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9FB3@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Jim Thompson'" <jim@musenki.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Bogomips and loops_per_jiffy
Date: Mon, 22 Apr 2002 11:57:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim

> I've noticed that about half the time, the kernels I build take what I
> think is a long time (> 20 seconds) in calibrate_delay().

I have exactly the same problem with my custom board using an 8260.
At every 5-10 times I start the kernel, it hangs on
'Calibrating delay loop...' for about 1 minute, and then yields
the same result (130.66 BogoMips).

I begun to try to debug that problem, but without any success yet. :-(
I've searched through the mailing lists, but did not find anything of
interest.

This problem is very annoying and I really want to fix it!


--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
