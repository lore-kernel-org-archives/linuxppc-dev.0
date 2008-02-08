Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 37D12DDEF1
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 04:19:50 +1100 (EST)
Message-ID: <47AC8F6A.8040900@ru.mvista.com>
Date: Fri, 08 Feb 2008 20:20:42 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 08/18] ide: move ide_port_setup_devices() call to
	ide_device_add_all()
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain>
	<20080208004516.17746.18498.sendpatchset@localhost.localdomain>
In-Reply-To: <20080208004516.17746.18498.sendpatchset@localhost.localdomain>
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

> Add ide_cfg_mtx lock/unlock to ide_port_setup_devices() and then move
> ide_port_setup_devices() call from init_irq() to ide_device_add_all().

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
