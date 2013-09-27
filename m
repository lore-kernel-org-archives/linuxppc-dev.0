Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B6DD2C0335
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 02:48:19 +1000 (EST)
Message-ID: <1380300453.24959.389.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] pci: fsl: rework PCI driver compatible with Layerscape
From: Scott Wood <scottwood@freescale.com>
To: Lian Minghuan-b31939 <B31939@freescale.com>
Date: Fri, 27 Sep 2013 11:47:33 -0500
In-Reply-To: <52456C0C.2020504@freescale.com>
References: <1379502122-20792-1-git-send-email-Minghuan.Lian@freescale.com>
 <1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com>
 <52456C0C.2020504@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-pci@vger.kernel.org, Zang Roy-R61911 <r61911@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-27 at 19:29 +0800, Lian Minghuan-b31939 wrote:
> Hi All,
> 
> Can anyone comment on my code or help to pick up?

Please break it up into multiple patches, each with one logical change
that is individually explained.  It will be much easier to review that
way.

-Scott
