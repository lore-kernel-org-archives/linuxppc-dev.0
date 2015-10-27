Return-Path: <vinod.koul@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 0409D1A0329
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 13:22:43 +1100 (AEDT)
Date: Tue, 27 Oct 2015 11:22:32 +0900
From: Vinod Koul <vinod.koul@intel.com>
To: Alexander Popov <alex.popov@linux.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Rob Herring <robh@kernel.org>,
 Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] powerpc/512x: add LocalPlus Bus FIFO device driver
Message-ID: <20151027022231.GF11691@vkoul-mobl.iind.intel.com>
References: <1444597682-22181-1-git-send-email-alex.popov@linux.com>
 <56280E66.2040804@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56280E66.2040804@linux.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 22, 2015 at 01:15:03AM +0300, Alexander Popov wrote:
> On 12.10.2015 00:08, Alexander Popov wrote:
> > This driver for Freescale MPC512x LocalPlus Bus FIFO (called SCLPC
> > in the Reference Manual) allows Direct Memory Access transfers
> > between RAM and peripheral devices on LocalPlus Bus.
> 
> > Changes in v4:
> >  - the race condition is fixed;
> >  - plenty of style fixes are made;
> >  - devm_* functions and EPROBE_DEFER are used in probe().
> 
> Hello,
> 
> I've done my best to fix the issues pointed by Timur Tabi and Vinod Koul.
> Could I have a feedback please?

I dont see to have v4 in my list :( Can you please repost

-- 
~Vinod
