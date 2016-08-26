Return-Path: <scott.wood@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0061.outbound.protection.outlook.com [104.47.1.61])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sLBKX164VzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 16:41:51 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Tillmann Heidsieck <theidsieck@leenox.de>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] powerpc: fsl_pci: fix inbound ATMU entries for
 systems with >4G RAM
Date: Fri, 26 Aug 2016 06:41:44 +0000
Message-ID: <DB5PR0401MB1928CAFDC18E2D3C2612F21B91EC0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <20160824194614.4014-1-theidsieck@leenox.de>
 <DB5PR0401MB19280DCC626ED0E83EDD0D3791EA0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <faa14fe5cf19881838df0ab1a402517f@mail.leenox.de>
 <DB5PR0401MB19287448C33B14B1DB47E81F91EC0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/26/2016 12:55 AM, Scott Wood wrote:=0A=
> On 08/26/2016 12:26 AM, Tillmann Heidsieck wrote:=0A=
>> On 2016-08-24 23:39, Scott Wood wrote:=0A=
>>> BTW, for some reason your patch is not showing up in Patchwork.=0A=
>>=0A=
>> Are there some known pitfalls when sending patches to Patchwork?=0A=
> =0A=
> It's not the first time I've seen certain people's patches not show up=0A=
> there, but I don't know what the root cause is.=0A=
=0A=
I do see the patch on Patchwork now; I guess it was just slow.=0A=
=0A=
-Scott=0A=
=0A=
