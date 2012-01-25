Return-Path: <b-cousson@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7367FB6F65
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 01:22:05 +1100 (EST)
Message-ID: <4F200DFD.7070407@ti.com>
Date: Wed, 25 Jan 2012 15:13:17 +0100
From: "Cousson, Benoit" <b-cousson@ti.com>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFCv2 00/14]
References: <1327352870-14687-1-git-send-email-grant.likely@secretlab.ca>
 <4F1DD6DF.4080706@gmail.com>
In-Reply-To: <4F1DD6DF.4080706@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Shawn Guo <shawn.guo@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1/23/2012 10:53 PM, Rob Herring wrote:
> On 01/23/2012 03:07 PM, Grant Likely wrote:
>>
>> Hey everyone,
>>
>> Here's the second RFC for the irq_domain patches.  I could use some
>> help testing now.  I still expect there will be a few bugs.  The
>> series is based on v3.3-rc1, and I've pushed it out to my git server:
>>
>> git://git.secretlab.ca/git/linux-2.6.git irqdomain/next
>
> Can you post to linux-arm-kernel too so people are aware of this work
> and stop posting dead-end irqdomain patches.

Good point, I have two pending series that are using the 
irq_domain_add() so far, so it will be good to have that branch pulled 
in arm-soc.

> I tested what you had as of this morning and it works fine for me. Looks
> like the only diff is the VExpress code. I'm working on rebasing my
> domain support for generic irqchip now.

In fact your generic irqchip should even avoid us to use 
irq_domain_add_legacy() since both GPIO and OMAP3 intc are already using 
the irqchip.

I guess you are not going to change the interface so the patches I did 
on your previous branch to try them should be good already, isn't it?

Thanks,
Benoit
