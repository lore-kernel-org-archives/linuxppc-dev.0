Message-ID: <392EB74D.69B40F4F@ccrl.mot.com>
Date: Fri, 26 May 2000 12:41:33 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Jim Lewis <jlewis@mvista.com>
CC: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root fs on hdd
References: <392E92E3.62847D28@ccrl.mot.com> <392EA146.757517C3@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Lewis wrote:

> You need to make the following soft link in your target :
> opt/hardhat/devkit/ppc/8xx/powerpc-linux ----> /

Yep. That did the trick!
Thanks,
Steve


--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
