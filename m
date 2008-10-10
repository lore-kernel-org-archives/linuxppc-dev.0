Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-122.bluehost.com (outbound-mail-122.bluehost.com
	[67.222.38.22]) by ozlabs.org (Postfix) with SMTP id 65A11DE3BB
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 03:09:12 +1100 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add legacy PCI access via sysfs
Date: Fri, 10 Oct 2008 09:02:29 -0700
References: <20081010025101.B48CADDEF7@ozlabs.org>
In-Reply-To: <20081010025101.B48CADDEF7@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810100902.30191.jbarnes@virtuousgeek.org>
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
>
> This is version 2, slightly different approach for getting at VGA
> memory which works a lot better with bridges providing a separate
> ISA Memory hole (which is the case of most of them).
>
> Also tested on a variety of hardware with a little tool using x86emu
> to run VGA BIOSes, do VBE calls and whack text mode.
>
> This patch relies on its generic counterpart, posted previously
> being applied first.
>
> Jesse, due to the dependency, it's better if we have both in
> the powerpc tree -or- both in the PCI tree, what do you think
> is best ? Either that or I have to delay applying it to powerpc
> until you get the generic part in.

Ah I was worried the first one might need a respin, but it applied fine, so 
I'll go ahead and apply this one too.

Thanks,
Jesse
