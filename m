Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A63DF2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 08:41:46 +1000 (EST)
Message-ID: <1380580888.24959.525.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] pci: fsl: rework PCI driver compatible with Layerscape
From: Scott Wood <scottwood@freescale.com>
To: Lian Minghuan-b31939 <B31939@freescale.com>
Date: Mon, 30 Sep 2013 17:41:28 -0500
In-Reply-To: <5248D94E.7080904@freescale.com>
References: <1379502122-20792-1-git-send-email-Minghuan.Lian@freescale.com>
 <1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com>
 <CAOZdJXUF3ibW5iuB-2p5bhPp-Uw9MVKzqZiDdukMfi4f1d3Phw@mail.gmail.com>
 <5248D94E.7080904@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-pci@vger.kernel.org, Zang Roy-R61911 <r61911@freescale.com>,
 Timur Tabi <timur@tabi.org>, Minghuan Lian <Minghuan.Lian@freescale.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-30 at 09:52 +0800, Lian Minghuan-b31939 wrote:
> Hi Timur,
> 
> Thanks for your comments.
> 
> How about PCI_FSL_COMMON?

Why not just have one symbol, which is used in the makefile in both
drivers/pci and arch/<whatever>?

-Scott
