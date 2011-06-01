Return-Path: <zajec5@gmail.com>
Received: from mail-qw0-f42.google.com (mail-qw0-f42.google.com
	[209.85.216.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4FEBB6F99
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jun 2011 05:14:53 +1000 (EST)
Received: by qwi4 with SMTP id 4so78515qwi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Jun 2011 12:14:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1306918871-16965-1-git-send-email-zajec5@gmail.com>
References: <1306918871-16965-1-git-send-email-zajec5@gmail.com>
Date: Wed, 1 Jun 2011 21:14:50 +0200
Message-ID: <BANLkTinSdDZv7gshYfi4mK5N9K-E7vk3Yw@mail.gmail.com>
Subject: Re: [RFT][PATCH 3.0] ssb: fix PCI(e) driver regression causing oops
	on PCI cards
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>, linux-wireless@vger.kernel.org,
	"John W. Linville" <linville@tuxdriver.com>,
	=?UTF-8?Q?Michael_B=C3=BCsch?= <mb@bu3sch.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	b43-dev@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2011/6/1 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>:
> We were incorrectly executing PCIe specific workarounds on PCI cards.
> This resulted in:
> Machine check in kernel mode.
> Caused by (from SRR1=3D149030): Transfer error ack signal
> Oops: Machine check, sig: 7 [#1]

John, I've tested this patch myself on my PCI BCM4318, including
checking for 0xFFFFFFFF reads in MMIO dumps.

The patch is correct, please take it for 3.0.

--=20
Rafa=C5=82
