Message-ID: <3DCBDC6D.2090001@acm.org>
Date: Fri, 08 Nov 2002 10:46:53 -0500
From: "Michael R. Zucca" <mrz5149@acm.org>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: NuBus SMP?
References: <Pine.GSO.4.21.0211081302390.23267-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
> Do there exist SMP NuBus Macs?

Not currently, but theoretically, I suppose if somebody supported a Radius
rocket, it could happen. Basically, a Radius Rocket was a 68030 (or 040?) + RAM
on a NuBus card. Theoretically, I suppose somebody could have a primitive kind
of SMP on a Mac with one of these machines. However, it's not clear to me what
kind of access a NuBus card has to the address space of the host system, so the
question may be moot if you're talking about simultaneous access to drivers.

Of course, this is all theoretical since nobody has managed to do this yet.

--
----------------------------------------------
  Michael Zucca - mrz5149@acm.org
----------------------------------------------
  "I'm too old to use Emacs." -- Rod MacDonald
----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
