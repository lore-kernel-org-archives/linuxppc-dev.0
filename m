Message-ID: <40D02781.506@246tNt.com>
Date: Wed, 16 Jun 2004 12:57:05 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5200 PCI questions
References: <42A622EB18325843894BB8E1040E3DF502274E@sinaexchf>
In-Reply-To: <42A622EB18325843894BB8E1040E3DF502274E@sinaexchf>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Iñigo Lopez Barranco wrote:

 > Hi. Is it possible, with the present version of BestComm, to use
 > DMA for IDE and PCI at the same time?

I don't really know how PCI DMA works in linux ? Is there generic hook
that must be implemented somewhere in the kernel and then are called
by all the drivers ?

 > As is not possible to use IDE DMA and the integrated FEC at this
 > moment, I'm thinking of using the integrated ATA controller in the
 > MPC5200 with DMA for an IDE disk and the PCI controller to
 > interface to a PCI to ethernet transceiver in a custom board. Is
 > this possible? Any recommended transceiver to use with linux and
 > the MPC5200?. Also, I would like to know if there is a known to
 > work PCI ethernet card (10/100 if possible) for use with the
 > Lite5200 kit, supported by linux. Thanks in advance.

I've just plugged a intel eepro100, and it's recognized. I can also
ping & telnet & ftp small files, but it freeze ( just the transfer )
for larger files ... Since I have the same behavior in the bootloader,
that may be a hardware issue ...



Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
