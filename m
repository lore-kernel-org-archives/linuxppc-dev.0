Message-ID: <3920414A.8B3AC43B@pop.agri.ch>
Date: Mon, 15 May 2000 20:26:26 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
CC: Linux-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc assembler help needed
References: <4.3.1.2.20000515180711.00b82540@mail.munich.netsurf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hoi Franz,

Franz Sirl wrote:
> No, cmpw 0,r5,0 compares r5 to r0, use cmpwi 0,r5,0 to make a signed
> compare of r5 against 0

This works, thanks. The next question is automatically in the queue:

all functions, insX/outsX in misc.S use this cmpw 0,r5,0, shouldn't it
be a cmpwi 0,r5,0 then?

Thanks,
Andreas

BTW, does it mind which CPU is behind? In my case it's a 601.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
