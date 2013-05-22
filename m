Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x232.google.com (mail-ea0-x232.google.com
 [IPv6:2a00:1450:4013:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C5FB32C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 07:17:53 +1000 (EST)
Received: by mail-ea0-f178.google.com with SMTP id q16so1466779ead.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 14:17:50 -0700 (PDT)
Message-ID: <519D35FA.2060002@gmail.com>
Date: Wed, 22 May 2013 23:17:46 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
To: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 11/12] ARM: kirkwood: remove redundant DT board files
References: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-12-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130522203633.GA28394@schnuecks.de> <519D30CF.9040904@gmail.com>
 <20130522210257.GM31290@titan.lakedaemon.net>
In-Reply-To: <20130522210257.GM31290@titan.lakedaemon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Lunn <andrew@lunn.ch>, Simon Baatz <gmbnomis@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/22/2013 11:02 PM, Jason Cooper wrote:
> On Wed, May 22, 2013 at 10:55:43PM +0200, Sebastian Hesselbarth wrote:
>> On 05/22/2013 10:36 PM, Simon Baatz wrote:
>>> Hi Sebastian,
>>>
>>> On Tue, May 21, 2013 at 06:41:49PM +0200, Sebastian Hesselbarth wrote:
>>>> With DT support for mv643xx_eth, board specific init for some boards now
>>>> is unneccessary. Remove those board files, Kconfig entries, and
>>>> corresponding entries in kirkwood_defconfig.
>>>>
>>>> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
>>>> ---
>>>> Note: board-km_kirkwood.c is also removed, as Valentin Longchamp confirmed
>>>> the lock-up is not caused by accessing clock gating registers but rather
>>>> non-existent device registers. This will be addressed by dtsi separation
>>>> for kirkwood and bobcat SoC variants.
>>>>
>>>> Changelog:
>>>> v3->v4:
>>>> - remove more boards that don't require board specific setup
>>>>
>> ...
>>
>> I would stick with "marvell,kirkwood" only. This is SoC init code and
>> we do not distinguish variants here at all.
>
> Agreed, nice catch Simon.

I just confirmed all kirkwood dts/dtsi properly set "marvell,kirkwood"
in their compatible strings. Will remove all other comapatible strings
from mach-kirkwood/board-dt.c as Simon suggested for v5.

Sebastian
