Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id EC70FDDEBF
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 04:18:02 +1100 (EST)
Message-ID: <47AC8EFC.8030506@ru.mvista.com>
Date: Fri, 08 Feb 2008 20:18:52 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 05/18] ide: factor out cable detection from ide_init_port()
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<20080208004455.17746.44570.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004455.17746.44570.sendpatchset@localhost.localdomain>
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

> * Factor out cable detection from ide_init_port() to ide_port_cable_detect().

> * Move ide_port_cable_detect() call to ide_device_add_all().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
