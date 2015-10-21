Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E7AF1A018C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 09:11:24 +1100 (AEDT)
Received: by lbbes7 with SMTP id es7so48612979lbb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 15:11:20 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v4 0/2] powerpc/512x: add LocalPlus Bus FIFO device driver
References: <1444597682-22181-1-git-send-email-alex.popov@linux.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Rob Herring <robh@kernel.org>,
 Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Popov <alex.popov@linux.com>
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <56280E66.2040804@linux.com>
Date: Thu, 22 Oct 2015 01:15:03 +0300
MIME-Version: 1.0
In-Reply-To: <1444597682-22181-1-git-send-email-alex.popov@linux.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12.10.2015 00:08, Alexander Popov wrote:
> This driver for Freescale MPC512x LocalPlus Bus FIFO (called SCLPC
> in the Reference Manual) allows Direct Memory Access transfers
> between RAM and peripheral devices on LocalPlus Bus.

> Changes in v4:
>  - the race condition is fixed;
>  - plenty of style fixes are made;
>  - devm_* functions and EPROBE_DEFER are used in probe().

Hello,

I've done my best to fix the issues pointed by Timur Tabi and Vinod Koul.
Could I have a feedback please?

Best regards,
Alexander
