Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 10C9EDDE3F
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 04:22:09 +1100 (EST)
Message-ID: <47AC8FF5.4010204@ru.mvista.com>
Date: Fri, 08 Feb 2008 20:23:01 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 02/18] ide: fix ide_find_port()
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<20080208004434.17746.33986.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004434.17746.33986.sendpatchset@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bartlomiej Zolnierkiewicz wrote:

> * Instead of checking for '->io_ports[IDE_DATA_OFFSET] == 0' check for
>   '->chipset == ide_unknown' when looking for an empty ide_hwifs[] slot.

> * Do ide-pnp initialization after ide-generic when IDE is built-in
>   (ide-pnp is the only user of ide_find_port() which needs such fixup).

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
