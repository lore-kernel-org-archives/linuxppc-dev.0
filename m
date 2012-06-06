Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9F20B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 04:20:17 +1000 (EST)
Message-ID: <4FCF9F45.4090103@freescale.com>
Date: Wed, 6 Jun 2012 13:19:49 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v5 2/5] powerpc/85xx: add HOTPLUG_CPU support
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-2-git-send-email-chenhui.zhao@freescale.com>
 <4FC933BF.1020901@freescale.com>
 <20120604110444.GA20676@localhost.localdomain>
 <4FCCE32F.1060301@freescale.com>
 <20120605111823.GB22427@localhost.localdomain>
 <4FCE30B8.2070902@freescale.com>
 <20120606095910.GB23505@localhost.localdomain>
In-Reply-To: <20120606095910.GB23505@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2012 04:59 AM, Zhao Chenhui wrote:
> On Tue, Jun 05, 2012 at 11:15:52AM -0500, Scott Wood wrote:
>> On 06/05/2012 06:18 AM, Zhao Chenhui wrote:
>>> If user does not enable kexec or hotplug, these codes are redundant.
>>> So use CONFIG_KEXEC and CONFIG_HOTPLUG_CPU to gard them.
>>
>> My point is that these lists tend to grow and be a maintenance pain.
>> For small things it's often better to not worry about saving a few
>> bytes.  For larger things that need to be conditional, define a new
>> symbol rather than growing ORed lists like this.
>>
>> -Scott
> 
> I agree with you in principle. But there are only two config options
> in this patch, and it is unlikely to grow. 

That's what everybody says when these things start. :-)

-Scott
