Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x22b.google.com (mail-ea0-x22b.google.com
 [IPv6:2a00:1450:4013:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A94882C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 04:55:09 +1000 (EST)
Received: by mail-ea0-f171.google.com with SMTP id b15so1377159eae.16
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 11:55:05 -0700 (PDT)
Message-ID: <519D1485.50801@gmail.com>
Date: Wed, 22 May 2013 20:55:01 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
To: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 06/12] ARM: dove: add gigabit ethernet and mvmdio device
 tree nodes
References: <519C9333.20609@gmail.com> <519C9822.9040909@windriver.com>
 <519C9A66.3050807@gmail.com> <20130522131010.GB31290@titan.lakedaemon.net>
 <20130522165908.GB12320@obsidianresearch.com> <519D0143.1000203@gmail.com>
 <20130522173505.GH31290@titan.lakedaemon.net> <519D038C.9000605@gmail.com>
 <20130522174815.GI31290@titan.lakedaemon.net> <519D1204.4090701@gmail.com>
 <20130522184936.GK31290@titan.lakedaemon.net>
In-Reply-To: <20130522184936.GK31290@titan.lakedaemon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Lennert Buytenhek <buytenh@wantstofly.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/22/2013 08:49 PM, Jason Cooper wrote:
> On Wed, May 22, 2013 at 08:44:20PM +0200, Sebastian Hesselbarth wrote:
>> On 05/22/2013 07:48 PM, Jason Cooper wrote:
>>> On Wed, May 22, 2013 at 07:42:36PM +0200, Sebastian Hesselbarth wrote:
>>>> Hmm, maybe a little bit too early. While restoring the MAC address now
>>>> works, another bug arises which I guess is related with phy setup
>>>> and aneg.
>>>>
>>>> Will investigate and update patch set accordingly.
>>>
>>> Cool, chances are, we should be able to take that patch in by itself for
>>> this merge window...
>>
>> Which patch do you mean? The local-mac-address workaround will only be
>> available for DT mv643xx_eth because it uses the DT node to store the
>> MAC.
>
> I thought you were replacing the unconditional ethernet clock grabbing
> with reading the mac from the registers and updating the dtb?  In
> mach-kirkwood/board-dt.c?

True. But there is no node for ethernet controllers in kirkwood.dtsi
yet. It will be there with mv643xx_eth DT patches applied and that is
when the corresponding replacement patch should also be taken in.

I was just confused about your referral to the merge window, because I
guess it is up to David Miller to decide when/whether to take
mv643xx_eth patches in.

Sebastian
