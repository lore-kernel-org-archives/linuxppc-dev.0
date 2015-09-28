Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7E961A002B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 23:21:04 +1000 (AEST)
Received: by labzv5 with SMTP id zv5so14669754lab.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 06:21:00 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v3 2/3] powerpc/512x: add a device tree binding for
 LocalPlus Bus FIFO
References: <1443115737-3948-1-git-send-email-alex.popov@linux.com>
 <1443115737-3948-3-git-send-email-alex.popov@linux.com>
 <560492C1.307@tabi.org>
To: Timur Tabi <timur@tabi.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <56093F89.1020004@linux.com>
Date: Mon, 28 Sep 2015 16:24:25 +0300
MIME-Version: 1.0
In-Reply-To: <560492C1.307@tabi.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25.09.2015 03:18, Timur Tabi wrote:
> Alexander Popov wrote:
>> +- dma-names: should be "rx-tx";
> 
> Why bother, if it can only be one value?

I've just followed devicetree/bindings/dma/dma.txt...
This "rx-tx" doesn't mean much but it could show that LocalPlus Bus FIFO
uses a single DMA read-write channel. Should I really drop it?

Best regards,
Alexander
