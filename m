Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:120:8448::d00d])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s5HmC2rFhzDqYb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 17:01:47 +1000 (AEST)
Date: Fri, 5 Aug 2016 09:01:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: york sun <york.sun@nxp.com>, Johannes Thumshirn <jthumshirn@suse.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
 "oss@buserror.net" <oss@buserror.net>, Stuart Yoder <stuart.yoder@nxp.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Kevin Hao <haokexin@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v3 01/11] arch/powerpc/pci: Fix compiling error for
 mpc85xx_edac
Message-ID: <20160805070126.GE25630@nazgul.tnic>
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
 <1470351518-22404-2-git-send-email-york.sun@nxp.com>
 <877fbvkhi3.fsf@concordia.ellerman.id.au>
 <AM4PR0401MB17321DA6630E78AF2ED7DA269A180@AM4PR0401MB1732.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AM4PR0401MB17321DA6630E78AF2ED7DA269A180@AM4PR0401MB1732.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 05, 2016 at 04:26:26AM +0000, york sun wrote:
> I don't have deep knowledge of this driver. What I am trying is to 
> separate the common DDR part and share it with ARM platforms. Along the 
> way, I found the compiling error if build a module. If exposing these 
> functions becomes a concern, I can live without it.

Perhaps you or Johannes could fix this properly to use pci_get_device()
as the rest of the EDAC drivers do, instead of exporting core PCI
functions...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
