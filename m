Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:120:8448::d00d])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s5Hhh1KDKzDrFq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 16:58:44 +1000 (AEST)
Date: Fri, 5 Aug 2016 08:58:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: york sun <york.sun@nxp.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
 "oss@buserror.net" <oss@buserror.net>, Stuart Yoder <stuart.yoder@nxp.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Kevin Hao <haokexin@gmail.com>, Yinghai Lu <yinghai@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v3 01/11] arch/powerpc/pci: Fix compiling error for
 mpc85xx_edac
Message-ID: <20160805065822.GD25630@nazgul.tnic>
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
 <1470351518-22404-2-git-send-email-york.sun@nxp.com>
 <8a1cbb34-1e5a-a7ee-1fc6-e6bd5db34aa1@au1.ibm.com>
 <AM4PR0401MB17322032D82792F305AF63A19A070@AM4PR0401MB1732.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AM4PR0401MB17322032D82792F305AF63A19A070@AM4PR0401MB1732.eurprd04.prod.outlook.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 04, 2016 at 11:39:14PM +0000, york sun wrote:
> I will rename it if I respin this patch for any reason. Otherwise, I 
> will send out another patch to rename it after merging.

Feel free to send an updated one as a reply to this thread.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
