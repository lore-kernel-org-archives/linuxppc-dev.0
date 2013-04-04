Return-Path: <B35336@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 045C52C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 12:20:49 +1100 (EST)
From: Zhao Chenhui-B35336 <B35336@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH 02/17] powerpc/85xx: do not sync time base at boot time
Date: Thu, 4 Apr 2013 01:20:40 +0000
Message-ID: <7AA2FF042C086D469F577FA6723434DA2845D5@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
 <1364994565-16010-2-git-send-email-chenhui.zhao@freescale.com>,
 <E5707E1B-20F9-495B-A83C-E115CDCEF4BE@kernel.crashing.org>
In-Reply-To: <E5707E1B-20F9-495B-A83C-E115CDCEF4BE@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=0A=
No other reason. Just avoid doing it again at boot time in kernel.=0A=
=0A=
-Chenhui=0A=
=0A=
________________________________________=0A=
From: Kumar Gala [galak@kernel.crashing.org]=0A=
Sent: Wednesday, April 03, 2013 23:10=0A=
To: Zhao Chenhui-B35336=0A=
Cc: linuxppc-dev@lists.ozlabs.org=0A=
Subject: Re: [PATCH 02/17] powerpc/85xx: do not sync time base at boot time=
=0A=
=0A=
On Apr 3, 2013, at 8:09 AM, Zhao Chenhui wrote:=0A=
=0A=
> From: Chen-Hui Zhao <chenhui.zhao@freescale.com>=0A=
>=0A=
> The bootloader have done time base sync for all cores, so skip=0A=
> the synchronization process at boot time of kernel.=0A=
>=0A=
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>=0A=
> Signed-off-by: Li Yang <leoli@freescale.com>=0A=
> Signed-off-by: Andy Fleming <afleming@freescale.com>=0A=
> ---=0A=
> arch/powerpc/platforms/85xx/smp.c |    8 ++++++++=0A=
> 1 files changed, 8 insertions(+), 0 deletions(-)=0A=
=0A=
What harm is there in doing the sync?  I'm sure there is another reason you=
 want to skip the TB sync that should be conveyed in the commit message.=0A=
=0A=
- k=0A=
