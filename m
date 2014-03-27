Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id EC8DC140088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 14:35:54 +1100 (EST)
Message-ID: <53339C96.3070406@tabi.org>
Date: Wed, 26 Mar 2014 22:35:50 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
Subject: Re: [PATCH 1/2] video/fsl: make the diu driver work without platform
 hooks
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
 <533320A0.8010507@tabi.org>
 <f6883c3f759a4544936acec5dc7e542b@BLUPR03MB373.namprd03.prod.outlook.com>
In-Reply-To: <f6883c3f759a4544936acec5dc7e542b@BLUPR03MB373.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jason.Jin@freescale.com wrote:
>>>>> However, the DIU is already initialized in u-boot and we can
>>>>> rely on the settings in u-boot for corenet platform,
>>>
>>> I don't like that at all.
> [Jason Jin-R64188] What's the potential issue of this? Most of the
> IPs need the platform initialization in u-boot. For example, the
> hwconfig in u-boot used for board specific settings for most
> platform.

The potential problem is that it's not stable.  Power management breaks 
your code.

I won't NACK your patch, but it feels like a band-aid rather than a real 
solution.
