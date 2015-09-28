Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96D841A002B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 23:11:47 +1000 (AEST)
Received: by lahh2 with SMTP id h2so159367872lah.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 06:11:44 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v3 3/3] dmaengine: mpc512x: initialize with
 subsys_initcall()
References: <1443115737-3948-1-git-send-email-alex.popov@linux.com>
 <1443115737-3948-4-git-send-email-alex.popov@linux.com>
 <5604925C.1050803@tabi.org>
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
 linux-kernel@vger.kernel.org, Alexander Popov <alex.popov@linux.com>
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <56093D5C.70809@linux.com>
Date: Mon, 28 Sep 2015 16:15:08 +0300
MIME-Version: 1.0
In-Reply-To: <5604925C.1050803@tabi.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25.09.2015 03:16, Timur Tabi wrote:
> Alexander Popov wrote:
>> Initialize Freescale MPC512x DMA driver with subsys_initcall()
>> to allow the depending drivers to call dma_request_slave_channel()
>> during their probe.
>>
>> Signed-off-by: Alexander Popov<alex.popov@linux.com>
> 
> Is there any way we can use -EPROBEDEFER instead?

Thanks Timur, I'll try.

Best regards,
Alexander
