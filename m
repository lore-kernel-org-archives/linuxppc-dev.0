Return-Path: <yifei_wang@hotmail.com>
Received: from bay0-omc4-s21.bay0.hotmail.com (bay0-omc4-s21.bay0.hotmail.com
	[65.54.190.223]) by ozlabs.org (Postfix) with ESMTP id 2B0D1B70EE
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Oct 2010 21:35:07 +1100 (EST)
Message-ID: <BAY158-ds45852D1FE75BC452A052FF5580@phx.gbl>
From: WANG YiFei <yifei_wang@hotmail.com>
To: <linuxppc-dev@ozlabs.org>
References: <BAY158-ds7DB18D88ED851794F4E19F5540@phx.gbl>
	<4CB522D1.5090802@windriver.com>
	<BAY158-ds2BEE228C7E27E7CE0C28BF5550@phx.gbl>
In-Reply-To: <BAY158-ds2BEE228C7E27E7CE0C28BF5550@phx.gbl>
Subject: Help about chip select on SPI slave devices
Date: Sat, 16 Oct 2010 18:35:10 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

We have a board which has 1 SPI master controller and 4 SPI slave =
devices, and we'd like to use 2 GPIOs to demux to chip select these =
slave devices.
Can anyone tell me if current powerpc dts support demuxer for chip =
select for spi slave devices? So far as I know, in dts, SPI master can =
only use 1 to 1 GPIO to CS(then needs 4 GPIOs).


Thanks in advance,
YiFei
