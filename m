Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id E1920DDEBE
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Feb 2008 05:10:07 +1100 (EST)
Message-ID: <47ADECB2.6030808@ru.mvista.com>
Date: Sat, 09 Feb 2008 21:10:58 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 07/18] ide: factor out devices init from
	ide_init_port_data()
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<20080208004509.17746.70379.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004509.17746.70379.sendpatchset@localhost.localdomain>
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

> * Factor out devices init from ide_init_port_data() to
>   ide_port_init_devices_data().

> While at it:

> * Add explicit clearing of IDE device structure.

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
