Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9F87FB6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Dec 2009 20:08:02 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: MPC5200B XLB Configuration Issues, FEC RFIFO Events, ATA Crashes
References: <200912091529.13913.roman.fietze@telemotive.de>
	<200912161237.09796.roman.fietze@telemotive.de>
	<4B2B3C3D.4090308@grandegger.com>
In-Reply-To: <4B2B3C3D.4090308@grandegger.com>
MIME-Version: 1.0
Message-ID: <200912181007.55792.roman.fietze@telemotive.de>
Date: Fri, 18 Dec 2009 10:07:55 +0100
Content-Type: Text/Plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfgang,

On Friday 18 December 2009 09:24:29 Wolfgang Grandegger wrote:

> What disc access modes, (pio, mwdma or udma) did you use for these tests.

MWDMA2.

On our hardware Linux 2.6 UDMA2 only works with very few disks. And on
top of that, UDMA seems to have problems on the MPC5200B with
concurrent traffic to or from the LPC (chips selects of peripherals
while a DMA transfer is active).

The same disks work without problems using UDMA2 on the old 2.4.25 on
exctly the same HW. Why? I don't know yet.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
