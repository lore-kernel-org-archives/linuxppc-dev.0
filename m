Return-Path: <vapier.adi@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 54B29B7CE4
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 06:35:49 +1100 (EST)
Received: by gwj20 with SMTP id 20so614152gwj.15
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Feb 2010 11:35:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100221001851.673db863@neptune.home>
References: <20100221001049.2f63f5d6@neptune.home>
	<20100221001851.673db863@neptune.home>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Mon, 22 Feb 2010 14:35:27 -0500
Message-ID: <8bd0f97a1002221135n6c52a657i1817063d2664bfda@mail.gmail.com>
Subject: Re: [PATCH 2/3] backlight: mark struct backlight_ops const
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Content-Type: text/plain; charset=UTF-8
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
	acpi4asus-user@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, dri-devel@lists.sourceforge.net,
	ibm-acpi-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T24gU2F0LCBGZWIgMjAsIDIwMTAgYXQgMTg6MTgsIEJydW5vIFByw6ltb250IHdyb3RlOgo+IMKg
ZHJpdmVycy92aWRlby9iZjU0eC1scTA0M2ZiLmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fCDCoCDCoDIgKy0KPiDCoGRyaXZlcnMvdmlkZW8vYmZpbi10MzUwbWNxYi1mYi5jIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfCDCoCDCoDIgKy0KCkFja2VkLWJ5OiBNaWtlIEZyeXNpbmdlciA8dmFw
aWVyQGdlbnRvby5vcmc+Ci1taWtlCg==
