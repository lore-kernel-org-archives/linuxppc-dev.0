Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-24.bluehost.com (outbound-mail-24.bluehost.com
	[69.89.21.19]) by ozlabs.org (Postfix) with SMTP id 25714DE1A3
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 04:39:21 +1100 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add legacy PCI access via sysfs
Date: Fri, 10 Oct 2008 10:39:18 -0700
References: <20081010025101.B48CADDEF7@ozlabs.org>
In-Reply-To: <20081010025101.B48CADDEF7@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810101039.18300.jbarnes@virtuousgeek.org>
Cc: linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday, October 9, 2008 7:50 pm Benjamin Herrenschmidt wrote:
> This patch adds support for legacy_io and legacy_mem files in
> bus class directories in sysfs for powerpc
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

Applied to linux-next, thanks.

Jesse
