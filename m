Message-ID: <638AA0336D7ED411928700D0B7B0D75B0189BB33@aimail.aiinet.com>
From: "Dayton, Dean" <deand@aiinet.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Enabling timebase on 8245
Date: Thu, 26 Sep 2002 16:29:40 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to run a variant of 2.4.19-rc3 on a Cogent CSB281 board
(MPC8245). The kernel boots to the point of printing

time_init: decrementer frequency = 0.000000MHz
Warning: real time clock seems stuck!
Calibrating delay loop...

The decrementer frequency is supposed to be determined by polling reading
the timebase before and after a one second delay. But the timebase is not
changing. I can't figure out out how to enable the timebase on an 8245 (it
doesn't seem to have a Timebase Status and Control Register like the 860).

Can anyone point me in the right direction?
Thanks
Dean



-------------
Dean Dayton
System Architect - Applied Innovation Inc.
(614)923-1174
deand@aiinet.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
