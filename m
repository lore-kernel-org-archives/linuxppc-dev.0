Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 832761A0100
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 07:39:13 +1100 (AEDT)
Received: by lbbec13 with SMTP id ec13so71092349lbb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 13:39:10 -0700 (PDT)
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v4 0/2] powerpc/512x: add LocalPlus Bus FIFO device driver
References: <1444597682-22181-1-git-send-email-alex.popov@linux.com>
 <56280E66.2040804@linux.com>
 <20151027022231.GF11691@vkoul-mobl.iind.intel.com>
To: Vinod Koul <vinod.koul@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, Rob Herring <robh@kernel.org>,
 Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Popov <alex.popov@linux.com>
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <562FE1D1.3010903@linux.com>
Date: Tue, 27 Oct 2015 23:42:57 +0300
MIME-Version: 1.0
In-Reply-To: <20151027022231.GF11691@vkoul-mobl.iind.intel.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27.10.2015 05:22, Vinod Koul wrote:
> On Thu, Oct 22, 2015 at 01:15:03AM +0300, Alexander Popov wrote:
>> On 12.10.2015 00:08, Alexander Popov wrote:
>>> This driver for Freescale MPC512x LocalPlus Bus FIFO (called SCLPC
>>> in the Reference Manual) allows Direct Memory Access transfers
>>> between RAM and peripheral devices on LocalPlus Bus.
>>
>>> Changes in v4:
>>>  - the race condition is fixed;
>>>  - plenty of style fixes are made;
>>>  - devm_* functions and EPROBE_DEFER are used in probe().
>>
>> Hello,
>>
>> I've done my best to fix the issues pointed by Timur Tabi and Vinod Koul.
>> Could I have a feedback please?
> 
> I dont see to have v4 in my list :( Can you please repost

Hello, Vinod

I'm sure I haven't miss your address in the list of the recipients.
Anyway I can repost.

Anatolij Gustschin wrote that he applied v4 with some fix to mpc5xxx/next
some time ago.

So should I repost v4 for everybody? How should I mark the reposted patches?

Best regards,
Alexander
