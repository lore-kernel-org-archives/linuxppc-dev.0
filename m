Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C55EC433F5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Mar 2022 02:04:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KQzfB74zgz3bgZ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Mar 2022 13:04:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=relay.hostedemail.com (client-ip=64.99.140.28;
 helo=relay.hostedemail.com; envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KQqDY230Qz2yYY
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2022 06:44:59 +1100 (AEDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay13.hostedemail.com (Postfix) with ESMTP id 76D8560704;
 Sat, 26 Mar 2022 19:44:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf04.hostedemail.com (Postfix) with ESMTPA id 4C2E220023; 
 Sat, 26 Mar 2022 19:44:26 +0000 (UTC)
Message-ID: <0441a5ec999492a8b03df0e6f649b19483006cbc.camel@perches.com>
Subject: Re: [PATCH 02/22] s3c: Replace comments with C99 initializers
From: Joe Perches <joe@perches.com>
To: Benjamin =?ISO-8859-1?Q?St=FCrz?= <benni@stuerz.xyz>, andrew@lunn.ch
Date: Sat, 26 Mar 2022 12:44:26 -0700
In-Reply-To: <20220326165909.506926-2-benni@stuerz.xyz>
References: <20220326165909.506926-1-benni@stuerz.xyz>
 <20220326165909.506926-2-benni@stuerz.xyz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: jsxopsrhtxuohu8717ojjus8n6gpgk4w
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4C2E220023
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+VHn75rxbHh4YHseFz2reFKFdl2HpQTKg=
X-HE-Tag: 1648323866-369401
X-Mailman-Approved-At: Sun, 27 Mar 2022 13:03:21 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-atm-general@lists.sourceforge.net, linux-ia64@vger.kernel.org,
 linus.walleij@linaro.org, dave.hansen@linux.intel.com,
 linux-pci@vger.kernel.org, robert.moore@intel.com, laforge@gnumonks.org,
 alim.akhtar@samsung.com, hpa@zytor.com, wcn36xx@lists.infradead.org,
 pkshih@realtek.com, linux-samsung-soc@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 dennis.dalessandro@cornelisnetworks.com, linux-rdma@vger.kernel.org,
 gregory.clement@bootlin.com, rafael.j.wysocki@intel.com, linux@armlinux.org.uk,
 krzk@kernel.org, jgg@ziepe.ca, mingo@redhat.com, 3chas3@gmail.com,
 linux-input@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 lenb@kernel.org, mike.marciniszyn@cornelisnetworks.com, rric@kernel.org,
 ajd@linux.ibm.com, arnd@arndb.de, kvalo@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 loic.poulain@linaro.org, bp@alien8.de, bhelgaas@google.com, tglx@linutronix.de,
 mchehab@kernel.org, linux-media@vger.kernel.org, linux@simtec.co.uk,
 linux-arm-kernel@lists.infradead.org, devel@acpica.org, isdn@linux-pingi.de,
 tony.luck@intel.com, nico@fluxnic.net, gregkh@linuxfoundation.org,
 dmitry.torokhov@gmail.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, james.morse@arm.com,
 netdev@vger.kernel.org, fbarrat@linux.ibm.com, sebastian.hesselbarth@gmail.com,
 pali@kernel.org, brgl@bgdev.pl
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2022-03-26 at 17:58 +0100, Benjamin Stürz wrote:
> This replaces comments with C99's designated
> initializers because the kernel supports them now.
[]
> diff --git a/arch/arm/mach-s3c/bast-irq.c b/arch/arm/mach-s3c/bast-irq.c
[]
> @@ -29,22 +29,22 @@
>   * the irq is not implemented
>  */
>  static const unsigned char bast_pc104_irqmasks[] = {
> -	0,   /* 0 */
> -	0,   /* 1 */
> -	0,   /* 2 */
> -	1,   /* 3 */
> -	0,   /* 4 */
> -	2,   /* 5 */
> -	0,   /* 6 */
> -	4,   /* 7 */
> -	0,   /* 8 */
> -	0,   /* 9 */
> -	8,   /* 10 */
> -	0,   /* 11 */
> -	0,   /* 12 */
> -	0,   /* 13 */
> -	0,   /* 14 */
> -	0,   /* 15 */
> +	[0]  = 0,
> +	[1]  = 0,
> +	[2]  = 0,
> +	[3]  = 1,
> +	[4]  = 0,
> +	[5]  = 2,
> +	[6]  = 0,
> +	[7]  = 4,
> +	[8]  = 0,
> +	[9]  = 0,
> +	[10] = 8,
> +	[11] = 0,
> +	[12] = 0,
> +	[13] = 0,
> +	[14] = 0,
> +	[15] = 0,
>  };

I don't find this better than the initial array.

>  
>  static const unsigned char bast_pc104_irqs[] = { 3, 5, 7, 10 };

For the same reason this array is just an array
without the specified indexing.


