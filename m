Return-Path: <speeder@alice.it>
Received: from smtp-out01.alice.it (smtp-out20.alice.it [85.33.2.20])
	by ozlabs.org (Postfix) with ESMTP id 5AA06DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 07:29:59 +1000 (EST)
Date: Mon, 16 Apr 2007 23:17:41 +0200
From: "[d]are [d]evil [c]oder, the-prince-of-flame" <speeder@alice.it>
To: linuxppc-embedded@ozlabs.org
Subject: DHT walnut
Message-Id: <20070416231741.02d155d9.speeder@alice.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,
i found a problem using a pci sound card in the DHT-WALNUT.
It has been correctly recognized by the kernel, the DMA feature (ppc405-dma) is setted, but the card is not working.

somebody says it is a bug, somebody says ppcboot solves the problem inizializing the pci in the correct way. I don't know, i'm using the uboot v1.1.4 and it is not working

also have a look to this

<> but i already thought so when i saw the "pci long" output
<> no BAR was assigned with an address
<> this was different some time ago
<> could be something changed in the last few months in the common pci support
<> i'll check with an ex-kollegue and let you know
<> this will take till beginning of next week though
<> hey, i just checked the source (sometimes helpful)
<> you just need to enable the host bridge configuration via an env variable
<> => setenv pciconfighost yes
<> then
<> => saveenv
<> => reset
<> after this reset the BAR1 will be configured:
<> => pci long
<> Scanning PCI devices on bus 0
<> Found PCI device 00.00.00:
<>   vendor ID =                   0x1014
<>   device ID =                   0x0156
<>   command register =            0x0006
<>   status register =             0x2210
<>   revision ID =                 0x01
<>   class code =                  0x0b (Processor)
<>   sub class code =              0x20
<>   programming interface =       0x00
<>   cache line =                  0x00
<>   latency time =                0x87
<>   header type =                 0x00
<>   BIST =                        0x00
<>   base address 0 =              0x00000000
<>   base address 1 =              0x80000008

could you help me to understand how to plug a soundcard ?
:)

best regards


-- 
i've pulled the plug
insert coins, please
