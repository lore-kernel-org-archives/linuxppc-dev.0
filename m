From: "Calum Selkirk" <cselkirk@xs4all.nl>
Date: Mon, 1 Dec 2003 21:23:07 +0100
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel oops when inserting a pcmcia card (2.6.0-test11)
Message-ID: <20031201202307.GR2408@xs4all.nl>
Reply-To: Calum Selkirk <cselkirk@xs4all.nl>
References: <20031201100909.GA26654@router.mmk-hagen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031201100909.GA26654@router.mmk-hagen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


* Uwe Steinmann [uwe.steinmann@mmk-hagen.de] [2003-12-01 11:09 +0100]:

> I find myself in xmon as soon as I insert a pcmcia card into my Pismo
> PowerBook. I suspect the memory range which is working for 2.4.21.

I don't have my Pismo here right now but from notes I belive these are
the correct memory ranges (in /etc/pcmcia/config.opts).

include port 0x1000-0x1fff
include memory 0x90000000-0x9003ffff

Comment out other values (from pcmcia-cs) ..

More information can be found here:

http://www.mpifr-bonn.mpg.de/div/iri/Archiv/LinuxPPC/PCMCIA.html

I'm using 2.2.21-benX also and pcmcia does work (tested with Orinoco and
SCSI cards).

best

cal
--
Systems Administrator
Piet Zwart Institute

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
