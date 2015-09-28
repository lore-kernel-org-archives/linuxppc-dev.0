Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B80A91A002B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 23:26:59 +1000 (AEST)
Subject: Re: [PATCH v3 2/3] powerpc/512x: add a device tree binding for
 LocalPlus Bus FIFO
To: alex.popov@linux.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Gerhard Sittig <gsi@denx.de>,
 Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1443115737-3948-1-git-send-email-alex.popov@linux.com>
 <1443115737-3948-3-git-send-email-alex.popov@linux.com>
 <560492C1.307@tabi.org> <56093F89.1020004@linux.com>
From: Timur Tabi <timur@tabi.org>
Message-ID: <5609401F.3010603@tabi.org>
Date: Mon, 28 Sep 2015 08:26:55 -0500
MIME-Version: 1.0
In-Reply-To: <56093F89.1020004@linux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Popov wrote:
> I've just followed devicetree/bindings/dma/dma.txt...
> This "rx-tx" doesn't mean much but it could show that LocalPlus Bus FIFO
> uses a single DMA read-write channel. Should I really drop it?

Hmmm, I'm not sure.  Is there anything else (besides your driver) that 
parses this device tree node?

dma.txt says this:

	"The specific strings that can be used are defined in the binding of 
the DMA client device."

So this looks like it's driver-specific, but it is a required property.
I guess you should keep it, but I think you should get a second opinion.
