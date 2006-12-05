Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id 81B3A67B6C
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 19:16:09 +1100 (EST)
Date: Tue, 5 Dec 2006 09:15:55 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: What is the correct way to indicate an unassigned PCI resource ?
Message-ID: <20061205081557.GA8483@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<45742253.1000807@ru.mvista.com>
	<20061204142201.68d9621f@localhost.localdomain>
	<1165293679.29784.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1165293679.29784.39.camel@localhost.localdomain>
Cc: linux-ide@vger.kernel.org, greg@kroah.com, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 05, Benjamin Herrenschmidt wrote:

> Olaf, can you give me a dump of /proc/ioports ? What is sitting at 0 on
> that PCI bus ?

with IDE=y

==> /proc/ioports <==
00000000-0000001f : dma1
00000020-00000021 : 8259 (master)
00000040-0000005f : timer
00000060-0000006f : i8042
00000080-0000008f : dma page reg
000000a0-000000a1 : 8259 (slave)
000000c0-000000df : dma2
000002f8-000002ff : serial
000003c0-000003df : matrox
000003f8-000003ff : serial
000004d0-000004d1 : 8259 edge control
00000898-0000089f : serial
0000f000-0000f007 : 0000:00:03.1
  0000f000-0000f007 : ide0
0000f010-0000f013 : 0000:00:03.1
  0000f012-0000f012 : ide0
0000f020-0000f027 : 0000:00:03.1
0000f030-0000f033 : 0000:00:03.1
0000f040-0000f04f : 0000:00:03.1
  0000f040-0000f047 : ide0
  0000f048-0000f04f : ide1
00010000-0001ffff : PCI Bus #01
00020000-0002ffff : PCI Bus #21
  0002ec00-0002ec3f : 0000:21:01.0
    0002ec00-0002ec3f : e100
00030000-0003ffff : PCI Bus #41
  0003e800-0003e8ff : 0000:41:01.0
    0003e800-0003e8ff : sym53c8xx
  0003ec00-0003ecff : 0000:41:01.1
    0003ec00-0003ecff : sym53c8xx
00040000-0004ffff : PCI Bus #61
00100000-001fffff : /pci@400000000112
  00100000-0010ffff : PCI Bus #01
  00110000-0011ffff : PCI Bus #21
    0011ec00-0011ec3f : 0001:21:01.0
      0011ec00-0011ec3f : e100
  00120000-0012ffff : PCI Bus #61
