Return-Path: <dan.j.williams@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id D1239B7162
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 08:12:00 +1000 (EST)
Received: by wwa36 with SMTP id 36so1942292wwa.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Sep 2010 15:11:58 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <492E9153-2D3E-4DA2-AD04-4F92C94DB3A7@kernel.crashing.org>
References: <1285066638-7473-1-git-send-email-leoli@freescale.com>
	<877FD0B5-19A7-4A16-831E-369B80B104EA@kernel.crashing.org>
	<AANLkTimiwtoa6i10OTcgFnvbvcO9N4KWHyt4Poj-yj=T@mail.gmail.com>
	<20100921163456.7e2c9b32@udp111988uds.am.freescale.net>
	<AANLkTine--kry0c0n87WOqYyi3AQOb2KnmNRs-MeXcQt@mail.gmail.com>
	<20100921164944.164ed0af@udp111988uds.am.freescale.net>
	<2C3F2C02-35B6-46AF-82DA-44ACCBFB8362@digitaldans.com>
	<AANLkTinKbBBbC1gmPewhn1f3MW-1MbARtiQZNX4w7Mi+@mail.gmail.com>
	<20100921171746.381f2e89@udp111988uds.am.freescale.net>
	<AANLkTinbjb+uQdby999rs1eF1sqPHY2vXJ1mVrznFv=0@mail.gmail.com>
	<492E9153-2D3E-4DA2-AD04-4F92C94DB3A7@kernel.crashing.org>
Date: Thu, 23 Sep 2010 15:11:57 -0700
Message-ID: <AANLkTinfHQGqWx2txwG4-nORcwcFD9dYstmVv8iK9oZ8@mail.gmail.com>
Subject: Re: [PATCH] fsldma: add support to 36-bit physical address
From: Dan Williams <dan.j.williams@intel.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
	Timur Tabi <timur.tabi@gmail.com>, Scott Wood <scottwood@freescale.com>,
	Dan Malek <ppc6dev@digitaldans.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 21, 2010 at 10:41 PM, Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
> On Sep 21, 2010, at 5:34 PM, Timur Tabi wrote:
>
>> On Tue, Sep 21, 2010 at 5:17 PM, Scott Wood <scottwood@freescale.com> wr=
ote:
>>
>>> It needs to be the actual device that is performing the DMA -- the
>>> platform may need to do things such as IOMMU manipulation where
>>> knowing the device matters.
>>
>> Ok, this all makes sense. =A0So it appears that the patch is valid, at
>> least in theory. =A0I would like to see some testing of it, but I
>> realize that may be too difficult. =A0There's no easy way to force an
>> allocation above 4GB.
>
> I think the patch is pretty safe w/o testing. =A0However I agree we need =
a better solution to testing 36-bit addressing.

I'll take that as an acked-by, but I'll wait for the next version of
the patch with the completed changelog before acting on it.

--
Dan
