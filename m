From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: <paulus@linuxcare.com.au>,
        Linux/PowerPC Devel List
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
Date: Tue, 17 Oct 2000 19:17:48 +0200
Message-Id: <19340911104932.6471@192.168.1.2>
In-Reply-To: <Pine.LNX.4.10.10010171543360.394-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10010171543360.394-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Some display cards (like voodoo) AFAIK, need us to tweak with the VGA IO
>> registers. The interest in having something like ioportremap or similar
>> is that we can have the platform specific code return a different base
>> for VGA than other legacy devices, thus allowing us to have, for example,
>> such a VGA card in the AGP slot and a legacy serial card in the PCI slots.
>                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>Do these exist? I'm aware of legacy serial cards for ISA slots only.
>AFAIK all PCI serial cards use PCI configuration and are handled
separately by
>serial.c.

Well, maybe they don't... this was an example provided by someone else. I
personally don't own anything that decodes legacy addresses anyway.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
