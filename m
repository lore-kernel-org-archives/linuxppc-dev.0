From: "Steven Vacca" <svacca@valcom.com>
To: "LinuxEmbeddedMailList" <linuxppc-embedded@lists.linuxppc.org>
Subject: usleep()
Date: Fri, 11 Jul 2003 09:19:34 -0400
Message-ID: <001401c347af$11ed2930$9b0ba8c0@valcom.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When I use usleep() in a thread in my app, does that
thread yield to the other threads during the entire
usleep() delay?
If not, what is the best way to execute a
delay in a thread, yielding the entire delay time until
the delay is finished?

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
