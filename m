Message-Id: <6.0.0.22.0.20031113151602.01e81908@192.168.2.1>
Date: Thu, 13 Nov 2003 15:25:35 +0100
To: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
From: llandre <r&d@wawnet.biz>
Subject: Re: Silicon Motion VGA controllers and PPC architecture
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20031113085435.N79832@invalid.ed.ntnu.no>
References: <5.1.1.6.0.20031112173538.01bd2e78@dns.struinfo.it>
 <20031113085435.N79832@invalid.ed.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > I'm looking for a VGA controller to use with an embedded PPC405-based
> system.
> > I had a look at the Silicon Motion chips (712/722) and they seem very
> > suited for embedded applications.
>
>Errr - may I ask what is special about this brand?

It seems these chips are the easiest to integrate in a PowerPC embedded
systems.
Laurent Mohin from Acterna confirmed it is possible to use them without
executing their x86 BIOS with a software emulator (U-Boot already includes
a driver that initializes the chip). See also his message in this thread.


Best regards,

llandre


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
