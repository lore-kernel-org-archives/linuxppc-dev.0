Message-ID: <8D7C5F56B409554D9D46AC22195807F30616F0@exchwenz01.smtp.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@DMCWave.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Cc: "'dmalek@jlc.net'" <dmalek@jlc.net>
Subject: mutli cast is not enabled in fec.c
Date: Tue, 26 Feb 2002 08:39:36 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are using Linux kernel 2.2.14 downloaded from Wolfgang's ftp web site.  I
believe that the kernel originally came from the Hard Hat distribution.  We
are looking at enabling RIP and / or OSPF routing in our product and I have
been asked why code in the function 'set_multicast_list' as been #ifdef'ed
out?  I am at a loss to know why so I though I would ask you guys why?

So can anybody tell me why a largish portion of the code has been
effectively commented out in this function.  I suggested to the developer
that he enables it and see what happens but I also was wondering if there is
another reason?


Regards,
Rod Boyce.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
