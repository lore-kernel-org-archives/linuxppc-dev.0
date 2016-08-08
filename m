Return-Path: <york.sun@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0073.outbound.protection.outlook.com [104.47.2.73])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7PMb4QBFzDqYt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 03:21:15 +1000 (AEST)
From: york sun <york.sun@nxp.com>
To: Borislav Petkov <bp@alien8.de>, Johannes Thumshirn <jthumshirn@suse.de>
CC: Michael Ellerman <mpe@ellerman.id.au>, "linux-edac@vger.kernel.org"
 <linux-edac@vger.kernel.org>, "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
 "oss@buserror.net" <oss@buserror.net>, Stuart Yoder <stuart.yoder@nxp.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Kevin Hao <haokexin@gmail.com>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>, Yinghai Lu <yinghai@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v3 01/11] arch/powerpc/pci: Fix compiling error for
 mpc85xx_edac
Date: Mon, 8 Aug 2016 15:47:41 +0000
Message-ID: <AM4PR0401MB17324D8BDE5C77E4FE8C37A79A1B0@AM4PR0401MB1732.eurprd04.prod.outlook.com>
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
 <1470351518-22404-2-git-send-email-york.sun@nxp.com>
 <877fbvkhi3.fsf@concordia.ellerman.id.au>
 <AM4PR0401MB17321DA6630E78AF2ED7DA269A180@AM4PR0401MB1732.eurprd04.prod.outlook.com>
 <20160805070126.GE25630@nazgul.tnic>
Reply-To: york sun <york.sun@nxp.com>
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

On 08/05/2016 12:01 AM, Borislav Petkov wrote:=0A=
> On Fri, Aug 05, 2016 at 04:26:26AM +0000, york sun wrote:=0A=
>> I don't have deep knowledge of this driver. What I am trying is to=0A=
>> separate the common DDR part and share it with ARM platforms. Along the=
=0A=
>> way, I found the compiling error if build a module. If exposing these=0A=
>> functions becomes a concern, I can live without it.=0A=
>=0A=
> Perhaps you or Johannes could fix this properly to use pci_get_device()=
=0A=
> as the rest of the EDAC drivers do, instead of exporting core PCI=0A=
> functions...=0A=
>=0A=
=0A=
Boris,=0A=
=0A=
I'd like to separate the first two patches from this set. They are not =0A=
really related to the DDR part I am working on. It will take me a while =0A=
to sort out the correct fix.=0A=
=0A=
York=0A=
