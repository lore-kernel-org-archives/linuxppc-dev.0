Message-Id: <200003081329.IAA16144@hoover.gilbarco.com>
From: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Serial buffer error??
Date: Wed, 8 Mar 2000 08:29:24 -0500
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lately my team has been seeing odd serial port hangs which seems to be
coming from the linux serial driver(16550).  I figured I ask the question
just in case anyone has seen it before.  Basically a simple test program
which just prints characters in an infinite loop ends up hanging after about
4096 characters, the serial buffer size, if we increase the buffersize, we
the hangup occurs there, so it is definitely related,  the weird part is
that if we press cntrl-c it starts to work again and prints out another 4096
characters or so.  Any ideas?

Thanks,
Jason

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
