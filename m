Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id C7F57DE1B9
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 04:13:32 +1000 (EST)
Message-ID: <468FD841.6070900@ru.mvista.com>
Date: Sat, 07 Jul 2007 22:15:29 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [ide] mmio ide support
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
In-Reply-To: <20070707094852.9473.21013.stgit@localhost.localdomain>
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

Hello.

Vitaly Bordug wrote:

> This adds support for MMIO IDE device like CompactFlash 
> in TrueIDE mode.

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com> 
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

[...]

> diff --git a/drivers/ide/legacy/mmio-ide.c b/drivers/ide/legacy/mmio-ide.c
> new file mode 100644
> index 0000000..77fb7dd
> --- /dev/null
> +++ b/drivers/ide/legacy/mmio-ide.c
[...]
> +	hwif->mmio = 2;

     That hwif->mmio is single-bit field now, so can only be 0 or 1.

MBR, Sergei
