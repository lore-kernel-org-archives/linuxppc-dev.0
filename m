Return-Path: <herbszt@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F3F61A01E7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 19:24:12 +1000 (AEST)
Date: Tue, 28 Apr 2015 11:18:11 +0200
From: Sebastian Herbszt <herbszt@gmx.de>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Sebastian Herbszt <herbszt@gmx.de>
Subject: Re: [PATCH kernel] commit 4fbdf9cb ("lpfc: Fix for lun discovery
 issue with saturn adapter.")
Message-ID: <20150428111811.0000556e@localhost>
In-Reply-To: <1430209582-23925-1-git-send-email-aik@ozlabs.ru>
References: <1430209582-23925-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-scsi@vger.kernel.org, James Smart <james.smart@emulex.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy wrote:
> This reverts 4fbdf9cb is breaks LPFC on POWER7 machine, big endian kernel.
> 
> This is the hardware used for verification:
> 0005:01:00.0 Fibre Channel [0c04]: Emulex Corporation Saturn-X: LightPulse Fibre Channel Host Adapter [10df:f100] (rev 03)
> 0005:01:00.1 Fibre Channel [0c04]: Emulex Corporation Saturn-X: LightPulse Fibre Channel Host Adapter [10df:f100] (rev 03)
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

This issue is not specific to POWER7. I hit it on x86 [1] and James
promised to look at it.

[1] http://marc.info/?l=linux-scsi&m=142938432414173

Sebastian
