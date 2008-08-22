Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by ozlabs.org (Postfix) with ESMTP id 39BDCDE810
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 14:35:10 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so198548pyi.27
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 21:34:31 -0700 (PDT)
Message-ID: <fa686aa40808212134l1e226845q41831ee567bb1a2@mail.gmail.com>
Date: Thu, 21 Aug 2008 22:34:31 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Mitch Bradley" <wmb@firmworks.com>
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
In-Reply-To: <fa686aa40808212130l365c6f5eu767b9969c8171e2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1219367743.26429.66.camel@jdub.homelinux.org>
	<20080821.205305.74123372.davem@davemloft.net>
	<fa686aa40808212118u710050bbg8ca8e04e01252310@mail.gmail.com>
	<20080821.212241.186479683.davem@davemloft.net>
	<48AE4093.8050504@firmworks.com>
	<fa686aa40808212130l365c6f5eu767b9969c8171e2@mail.gmail.com>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	devicetree-discuss@ozlabs.org,
	David Miller <davem@davemloft.net>, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 21, 2008 at 10:30 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Thu, Aug 21, 2008 at 10:29 PM, Mitch Bradley <wmb@firmworks.com> wrote:
>> Hi, I wrote most of 1275.
>>
>> Mitch Bradley  (wmb@firmworks.com)
>
> Hi Mitch,
>
> What is your suggestion.  Where should we be discussing new device
> tree bindings?  Whether it be real Open Firmware, or flattened device
> tree, or something in between

...and along those lines: is there a place for documenting new
bindings?  Lacking anything better, those of us in PowerPC-Linux-land
have been adding documentation to Documentation/powerpc/dts-bindings/*
in the Linux kernel tree.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
