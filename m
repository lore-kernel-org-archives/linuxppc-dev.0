Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
To: paulus@samba.org
Cc: acurtis@onz.com, dan@embeddededge.com,
	linuxppc-embedded@lists.linuxppc.org
From: acurtis@onz.com
Subject: RE: 8260 Memory Management
Date: Fri, 23 Aug 2002 17:36:58 -0700 (PDT)
Message-Id: <20020823173658.25567.h002.c007.wm@mail.directvinternet.com.criticalpath.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> &gt; Basically, remove all the CONFIG_8260 conditional compile stuff.
>
> I just looked in arch/ppc in the linuxppc_2_4_devel tree and there are
> only 3 places where CONFIG_8260 is used in the code.  Two of them are
> for the cheesy request_8xxirq thing.  The other is for m8260_gorom.
> So I'm not sure what you're referring to.

You need to look in include/asm-ppc. There is things related to address
translation too.

> Dan, can we *please* take out the #define request_irq request_8xxirq
> and just use request_irq like everyone else?

I already have a patch for this. Do you want it? I was getting ready to submit
several updates.

TIA

------------------------------------------------------------
Allen Curtis              |  All good things come to those
Ones and Zeros, Inc.      |  who wait. Some of us have to
mailto:acurtis@onz.com    |  wait a little longer.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
