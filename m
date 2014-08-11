Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC16D1A071E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 20:12:36 +1000 (EST)
Date: Mon, 11 Aug 2014 11:02:41 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH 3/5] mmc: sdhci-pltfm: Do not use parent as the host's
 device
Message-ID: <20140811100241.GB30401@n2100.arm.linux.org.uk>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
 <1406298233-27876-3-git-send-email-pawel.moll@arm.com>
 <1407515785.31897.28.camel@hornet>
 <CAPDyKFoLU6pnJFmKe7CB0q-hKfwv4uCPSr0cE4aoYMvfhjMteQ@mail.gmail.com>
 <1407748550.3680.10.camel@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407748550.3680.10.camel@hornet>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Anton Vorontsov <anton@enomsg.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Chris Ball <chris@printf.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "arm@kernel.org" <arm@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>,
 Olof Johansson <olof@lixom.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paul@pwsan.com" <paul@pwsan.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 11, 2014 at 10:15:50AM +0100, Pawel Moll wrote:
> On Mon, 2014-08-11 at 10:07 +0100, Ulf Hansson wrote:
> > Sorry for the delay. I suppose this make sense, but I really don't
> > know for sure.
> > 
> > I guess we need some testing in linux-next, to get some confidence.
> 
> Would you take it into -next then? Unless I'm completely wrong there
> should be no impact on any in-tree driver...

But not until 3.17-rc1 has been released.  linux-next should not receive
new material other than bug fixes while a merge window is open.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
