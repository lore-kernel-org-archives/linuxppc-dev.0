Return-Path: <marc.zyngier@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3ySLVp3yHkzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 21:12:31 +1100 (AEDT)
Subject: Re: [PATCH v10 0/4] this patchset is to remove PPCisms for QEIC
To: Thomas Gleixner <tglx@linutronix.de>, Qiang Zhao <qiang.zhao@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jason Cooper
 <jason@lakedaemon.net>, "oss@buserror.net" <oss@buserror.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1502075236-24078-1-git-send-email-qiang.zhao@nxp.com>
 <AM3PR04MB1185BD257F6BDE880B2C92B391470@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <AM3PR04MB11852211CAFA9741B260D4A3915E0@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <87bmkm95te.fsf@concordia.ellerman.id.au>
 <AM3PR04MB11851996C67BF447B8192821915F0@AM3PR04MB1185.eurprd04.prod.outlook.com>
 <alpine.DEB.2.20.1711011808260.1942@nanos>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <4939804e-a796-d1ce-39cb-9b518dca588b@arm.com>
Date: Thu, 2 Nov 2017 10:12:22 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1711011808260.1942@nanos>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/11/17 17:09, Thomas Gleixner wrote:
> On Wed, 1 Nov 2017, Qiang Zhao wrote:
>> Michael Ellerman <mpe@ellerman.id.au> wrote
>>>
>>> Qiang Zhao <qiang.zhao@nxp.com> writes:
>>>
>>>> Hi all,
>>>>
>>>> Could anybody review this patchset and take action on them? Thank you!
>>>
>>> Who maintains this? I don't actually know, it's not powerpc code, or is it?
>>
>> Yes, it's not powerpc code, it is irqchip code, maintained by Thomas, Jason and Marc according to MAINTAINERS file.
>>
>> Hi Thomas, Jason and Marc,
>>
>> Could you keep an eye on this patchset? Thank you!
> 
> It's on my radar, but I have zero capacity at the moment. Hopefully Marc
> can spare a few cycles.
I'll try, but I haven't been cc-ed on that one. I'll try to dig it out.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
