Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-158.bluehost.com (outbound-mail-158.bluehost.com
	[67.222.39.38]) by ozlabs.org (Postfix) with SMTP id 6C74CDE29F
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 23:23:17 +1100 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add legacy PCI access via sysfs (v3)
Date: Wed, 15 Oct 2008 05:16:29 -0700
References: <20081014005701.A17D2DDF6A@ozlabs.org>
In-Reply-To: <20081014005701.A17D2DDF6A@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810150516.29683.jbarnes@virtuousgeek.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday, October 13, 2008 5:55 pm Benjamin Herrenschmidt wrote:
> This patch adds support for legacy_io and legacy_mem files in
> bus class directories in sysfs for powerpc
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ok, applied this one.  Should be pushing to Linus soon.

Thanks,
Jesse
