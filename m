Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DA0742C0132
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 08:56:29 +1000 (EST)
Message-ID: <5212A293.2030903@wwwdotorg.org>
Date: Mon, 19 Aug 2013 16:56:19 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] i2c: move of helpers into the core
References: <1376918361-7014-1-git-send-email-wsa@the-dreams.de>
 <3792014.HtzPVmLjnf@vostro.rjw.lan>
In-Reply-To: <3792014.HtzPVmLjnf@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Cc: Wolfram Sang <wsa@the-dreams.de>,
 Kevin Hilman <khilman@deeprootsystems.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sekhar Nori <nsekhar@ti.com>,
 linux-i2c@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Kukjin Kim <kgene.kim@samsung.com>, linux-acpi@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>,
 Alessandro Rubini <rubini@unipv.it>, devicetree@vger.kernel.org,
 linux-media@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Jean Delvare <khali@linux-fr.org>, linux-samsung-soc@vger.kernel.org,
 Ben Dooks <ben-linux@fluff.org>, Barry Song <baohua.song@csr.com>,
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 davinci-linux-open-source@linux.davincidsp.com, linux-kernel@vger.kernel.org,
 Tony Prisk <linux@prisktech.co.nz>, Kyungmin Park <kyungmin.park@samsung.com>,
 Ludovic Desroches <ludovic.desroches@atmel.com>, Rob Landley <rob@landley.net>,
 STEricsson <STEricsson_nomadik_linux@list.st.com>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Len Brown <lenb@kernel.org>, Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2013 05:04 PM, Rafael J. Wysocki wrote:
> On Monday, August 19, 2013 03:19:18 PM Wolfram Sang wrote:
>> I2C of helpers used to live in of_i2c.c but experience (from SPI) shows
>> that it is much cleaner to have this in the core. This also removes a
>> circular dependency between the helpers and the core, and so we can
>> finally register child nodes in the core instead of doing this manually
>> in each driver. So, fix the drivers and documentation, too.
> 
> Perhaps we should do the analogous for ACPI then?
> 
> Rafael

Aargh. Why quote the entire patch just to say one line?
