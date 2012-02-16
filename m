Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 268111007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 06:48:33 +1100 (EST)
Message-ID: <4F3D5D84.2040609@freescale.com>
Date: Thu, 16 Feb 2012 13:48:20 -0600
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 1/1] fsldma: ignore end of segments interrupt
References: <1327611520-18256-1-git-send-email-iws@ovro.caltech.edu>
 <CAOZdJXVccE0GqZU2PvAz3RTh+X9ZYZr-9YufxS+mYWJkhSOGEQ@mail.gmail.com>
 <20120216190040.GA9262@ovro.caltech.edu> <4F3D5A28.4010905@freescale.com>
 <20120216194655.GD9262@ovro.caltech.edu>
In-Reply-To: <20120216194655.GD9262@ovro.caltech.edu>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Dan Williams <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ira W. Snyder wrote:

> No. I don't have the ability to connect my P2020 up to an FPGA to
> recreate the DMA workload that causes this on my 8349EA. I can run the
> dmatest module, if you'd like.

I just want to make sure your patch doesn't break 85xx.

-- 
Timur Tabi
Linux kernel developer at Freescale
