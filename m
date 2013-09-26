Return-Path: <B45939@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 101AC2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 15:06:31 +1000 (EST)
Message-ID: <5243C0D1.4070808@freescale.com>
Date: Thu, 26 Sep 2013 13:06:25 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v10 2/3] DMA: Freescale: Add new 8-channel DMA engine
 device tree nodes
References: <1379499333-4745-1-git-send-email-hongbo.zhang@freescale.com>
 <1379499333-4745-3-git-send-email-hongbo.zhang@freescale.com>
 <524074A7.7000001@wwwdotorg.org> <524169E3.7030408@freescale.com>
 <5241CC60.5070204@wwwdotorg.org> <52429252.10009@freescale.com>
 <1380159992.24959.248.camel@snotra.buserror.net>
 <20130926022859.GL9625@voom.redhat.com>
In-Reply-To: <20130926022859.GL9625@voom.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ian.campbell@citrix.com,
 pawel.moll@arm.com, Stephen Warren <swarren@wwwdotorg.org>,
 vinod.koul@intel.com, linux-kernel@vger.kernel.org, rob.herring@calxeda.com,
 djbw@fb.com, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/26/2013 10:28 AM, David Gibson wrote:
> On Wed, Sep 25, 2013 at 08:46:32PM -0500, Scott Wood wrote:
>> On Wed, 2013-09-25 at 15:35 +0800, Hongbo Zhang wrote:
>>> By the way, I know maybe it is difficult, but why not introduce a
>>> document of maintaining rules for the dt binding docs? we have dedicated
>>> maintainers for this part now. Description language from one submitter
>>> cannot satisfy every reviewer/maintainer, for a reg property, is it
>>> necessary to say "offset and length",
>> Don't say "offset and length".  It's both redundant with the base
>> definition of the reg property, and overly specific because it makes
>> assumptions about how the parent node's ranges are set up (sometimes we
>> want to be that specific, but usually not).

Thanks for your answer Scott.
In fact my questions are mainly sample questions to file the necessary 
rules of dt binding.
> To look at it another way, the format of the 'reg' property is defined
> by the parent bus's binding, not the binding of the node itself.
>
Whatever the rule is, if it is reasonable and accepted, just as I said, 
we need to file it.
