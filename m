Return-Path: <B04825@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C0D272C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 01:20:03 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Zhao Chenhui-B35336 <B35336@freescale.com>
Subject: Re: [PATCH v7 1/5] powerpc/85xx: implement hardware timebase sync
Date: Wed, 4 Jul 2012 15:19:54 +0000
Message-ID: <4FF45F19.2080607@freescale.com>
References: <1341310879-5468-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXUeY-_mmBLoA25_g4eLqwHxYX4c_ECbU+KYqfM307THNQ@mail.gmail.com>
 <20120704031426.GA6133@localhost.localdomain>
 <4FF3B5B6.8090400@freescale.com>
 <20120704034545.GA6196@localhost.localdomain>
In-Reply-To: <20120704034545.GA6196@localhost.localdomain>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Zhao Chenhui wrote:
> On Tue, Jul 03, 2012 at 10:17:12PM -0500, Tabi Timur-B04825 wrote:
>> Zhao Chenhui wrote:
>>> If the guts variable is NULL, it indicates there is error in dts or ker=
nel.
>>> We should fix the error, rather than ignore it.
>>
>> And that's why there's a warning message.  Crashing the kernel is not
>> going to fix anything.
>>
>
> This error likely crashes the kenel somewhere.

Can you test this, please?

The point I'm trying to make is that it's wrong to intentionally halt the=20
kernel unless you're sure that it's the best option.  A missing device=20
tree node is supposed to only disable a given feature, not break everything=
.

--=20
Timur Tabi
Linux kernel developer at Freescale
