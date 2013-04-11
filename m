Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-oa0-f46.google.com (mail-oa0-f46.google.com
 [209.85.219.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B481C2C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 02:59:15 +1000 (EST)
Received: by mail-oa0-f46.google.com with SMTP id h2so381647oag.33
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 09:59:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130411153256.GH1910@1wt.eu>
References: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130411131333.GD1910@1wt.eu>
 <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
 <20130411150326.GA19978@1wt.eu>
 <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
 <20130411153256.GH1910@1wt.eu>
Date: Thu, 11 Apr 2013 18:59:11 +0200
Message-ID: <CABJ1b_QaEJbuBsqx+J1Pkc7o66S_Rboa7Trnko1mXSK6-UZhfg@mail.gmail.com>
Subject: Re: [PATCH] net: mv643xx_eth: Add GRO support
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Soeren Moch <smoch@web.de>, Paul Mackerras <paulus@samba.org>,
 linux-arm-kernel@lists.infradead.org, Dale Farnsworth <dale@farnsworth.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Florian Fainelli <florian@openwrt.org>,
 Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 11, 2013 at 5:32 PM, Willy Tarreau <w@1wt.eu> wrote:
> On Thu, Apr 11, 2013 at 05:27:03PM +0200, Sebastian Hesselbarth wrote:
>> I don't have a strong opinion on whether Soeren's or your proposal should
>> be submitted. But I insist on having one of them in, as GRO significantly
>> improves the common use case, is enabled by default, and not as
>> constrained as LRO.
>
> I agree, use yours first, but we should keep an eye on this. Since you have
> everything to run a test, please try to see if you can get netperf to run
> over IPv6, I'm sure the NIC doesn't handle it.

Willy,

out of curiosity I replayed all tests using netperf/netserver with -6 which
enables ipv6. The overall results remain quite the same here:
enabling support for GRO gives a huge improvement in achievable
throughput, and the difference between Soeren's and your patch is
neglectible.

Sebastian
