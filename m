Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 34D0BDDFDD
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 04:07:55 +1100 (EST)
Message-ID: <47558979.40002@ru.mvista.com>
Date: Tue, 04 Dec 2007 20:08:09 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 4/4] [libata] pata_platform: s/ioport_shift/reg_shift/g
References: <20071204170442.GA10460@localhost.localdomain>
	<20071204170745.GD15599@localhost.localdomain>
In-Reply-To: <20071204170745.GD15599@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Anton Vorontsov wrote:

> This patch renames ioport_shift member of pata_platform_info
> structure to reg_shift. Users of pata_platform are followed
> appropriately.

> Rationale of that change is: shifting applies to the whole memory
> mapped region, not only to the command block of the ATA registers,
> despite the fact that shifting is meaningless for ctl register.

> This patch should make Sergei Shtylyov a bit more happy. ;-)

    In fact, I don't care about how platform driver calls this stuff. ;-)
I only care about the property name.

MBR, Sergei
