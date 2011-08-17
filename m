Return-Path: <B34182@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0037B6F95
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 19:45:53 +1000 (EST)
From: Liu Gang-B34182 <B34182@freescale.com>
To: "'Bounine, Alexandre'" <Alexandre.Bounine@idt.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rio: Use discovered bit to test if enumeration is complete
Date: Wed, 17 Aug 2011 09:45:48 +0000
Message-ID: <9A1C2A9ACC704641BC472A1588CE16470EB559@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1312856226-3695-1-git-send-email-b34182@freescale.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552020244E5@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552020244E5@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>,
	"'akpm@linux-foundation.org'" <akpm@linux-foundation.org>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	Li Yang-R58472 <r58472@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Andrew,

Could you please apply this patch into your tree?

Thanks a lot!

Regards,

Liu Gang

-----Original Message-----
From: Bounine, Alexandre [mailto:Alexandre.Bounine@idt.com]=20
Sent: Tuesday, August 09, 2011 8:36 PM
To: Liu Gang-B34182; linux-kernel@vger.kernel.org
Cc: Li Yang-R58472; Zang Roy-R61911; linuxppc-dev@ozlabs.org; Liu Gang-B341=
82; akpm@linux-foundation.org; Gala Kumar-B11780
Subject: RE: [PATCH] rio: Use discovered bit to test if enumeration is comp=
lete

On Monday, August 08, 2011 at 10:17 PM, Liu Gang wrote:
> Subject: [PATCH] rio: Use discovered bit to test if enumeration is=20
> complete
>=20
> The discovered bit in PGCCSR register indicates if the device has been=20
> discovered by system host. In Rapidio system, some agent devices can=20
> also be master devices. They can issue requests into the system.
>=20
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
>  drivers/rapidio/rio-scan.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>
