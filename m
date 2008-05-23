Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DA2AFDE166
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 04:27:56 +1000 (EST)
Date: Fri, 23 May 2008 22:27:54 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-mmc@drzeus.cx>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC] OpenFirmware bindings for the MMC-over-SPI driver
Message-ID: <20080523182754.GA26891@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org
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

This is second attempt to write the OpenFirmware bindings for the
MMC-over-SPI (and SPI bindings in general). First attempt[1] was discussed
in the linuxppc-dev list only, since I tried to do the bindings without
touching the drivers them self. That attempt got a cool welcome, so here
is an alternative.

Grant, I'm somewhat sure you'll like it now... :-) As a plus, these
bindings doesn't require changes to the spi_of core...

[1] http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056727.html

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
