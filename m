Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
To: trini@kernel.crashing.org
Cc: acurtis@onz.com, dan@embeddededge.com,
	linuxppc-embedded@lists.linuxppc.org, paulus@samba.org
From: acurtis@onz.com
Subject: Re: 8260/8xx IRQ patch
Date: Tue, 27 Aug 2002 17:31:28 -0700 (PDT)
Message-Id: <20020827173128.20304.h022.c007.wm@mail.directvinternet.com.criticalpath.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Definatly not for 2.4, for 8xx.  And did you test this on an 8xx board?

I do not have an 8xx board but I have tested it on the 8260. On the 8260 if you
loaded a module that wanted to call request_irq() you crashed in a stub function.
No mapping to request_8xxirq() from request_irq().

I could make this 8260 specific if you want.

------------------------------------------------------------
Allen Curtis              |  All good things come to those
Ones and Zeros, Inc.      |  who wait. Some of us have to
mailto:acurtis@onz.com    |  wait a little longer.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
