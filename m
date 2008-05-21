Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D31B3DE140
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 01:41:04 +1000 (EST)
Date: Wed, 21 May 2008 19:41:03 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC/DRAFT] SPI OF bindings, MMC-over-SPI, chip-selects and so on
Message-ID: <20080521154103.GA32577@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

This is just a bait for further discussion of OF/SPI, chip-selects,
e.t.c.

I've converted the spi_mpc83xx to the OF driver (using Grant's
SPI_MASTER_OF work + some additions), and implemented MMC-over-SPI
bindings. This stuff extensively using GPIOs, and I think this will
work for the "bridged SPI" too, since the SPI bridge could be
represented as GPIO controller (inside the SPI controller node).

Thoughts?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
