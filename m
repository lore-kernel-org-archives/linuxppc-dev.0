Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x230.google.com (mail-ea0-x230.google.com
 [IPv6:2a00:1450:4013:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 634A32C02C9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 20:24:17 +1000 (EST)
Received: by mail-ea0-f176.google.com with SMTP id k11so3915879eaj.35
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2013 03:24:12 -0700 (PDT)
Message-ID: <51A33447.80305@gmail.com>
Date: Mon, 27 May 2013 12:24:07 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] ARM: kirkwood: proper retain MAC address workaround
 on DT ethernet
References: <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130525.210441.818472895703230779.davem@davemloft.net>
 <51A26B62.4050009@gmail.com>
 <20130527.022339.791886107453761860.davem@davemloft.net>
 <1369647565.3557.28.camel@pasglop>
In-Reply-To: <1369647565.3557.28.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: andrew@lunn.ch, jason@lakedaemon.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, buytenh@wantstofly.org, grant.likely@linaro.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/27/13 11:39, Benjamin Herrenschmidt wrote:
> On Mon, 2013-05-27 at 02:23 -0700, David Miller wrote:
>> Sparc has an of_set_property(), it needs to become generic.
>
> There is an of_update_property(), we could change the name though, yours
> is nicer :-)

Ben, David,

I had a quick look at sparc's of_set_property. Nothing special except it
depends on OF_DYNAMIC at some place. Using of_update_property instead
should be the correct function to use. Thanks for the hint, I'll update
the patches accordingly and send v5 hopefully by today.

Sebastian
