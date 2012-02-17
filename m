Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2AECCB6F98
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 14:17:47 +1100 (EST)
Message-ID: <1329448660.2892.42.camel@pasglop>
Subject: RE: [PATCH V2 RESEND] fsl-sata: I/O load balancing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liu Qiang-B32616 <B32616@freescale.com>
Date: Fri, 17 Feb 2012 14:17:40 +1100
In-Reply-To: <BCB48C05FCE8BC4D9E61E841ECBE6DB702B97D@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1329284944-17943-1-git-send-email-qiang.liu@freescale.com>
 <1329439216.2892.36.camel@pasglop>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB702B97D@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "jgarzik@pobox.com" <jgarzik@pobox.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-02-17 at 01:54 +0000, Liu Qiang-B32616 wrote:
> The default will be set in a common interface fsl_sata_set_irq_coalescing when
> initialize the controller. This interface will check the range of intr count
> and ticks and make sure the values are reasonably.

Allright, but the current defaults are basically no coalescing right ?

> It's hard to find a aggressive value to adapt all scenarios, so I use echo to adjust
> the value. I remember P5020 have some performance issue, I will check it.
> BTW, which filesystem do you use? Ext2 is lower than ext4 because metadata is 
> continuously wrote to disk. You can try ext4 or xfs. 

ext3 at the moment, I plan to switch to ext4 when I finish that fsck
pass which is taking hours... I am not aware of the 5020 performance
issues, is this something documented and/or fixable ?

Cheers,
Ben.
