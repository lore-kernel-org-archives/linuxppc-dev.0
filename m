Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19639B7B70
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 23:49:25 +1100 (EST)
Message-ID: <4AD71A40.1090402@embedded-sol.com>
Date: Thu, 15 Oct 2009 14:49:04 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: Re: UBIFS problem on MPC8536DS
References: <4AD5ADC9.30503@embedded-sol.com> <4AD6F172.6030407@aimvalley.nl>
In-Reply-To: <4AD6F172.6030407@aimvalley.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Norbert

Norbert van Bolhuis wrote:
> Hi Felix,
>
> do you have CONFIG_NO_HZ defined ?
>
> I've seen similar problems with powerpc + CONFIG_NO_HZ. In my case the 
> low-level
> do_write_buffer (cfi_cmdset_0002.c) timed out too early. See
> http://lkml.org/lkml/2009/9/3/84
>
> Maybe in your case it's the do_erase_chip timing out too early.
>
> ---
> NvBolhuis.
>
Thanks for suggestion.

I have CONFIG_NO_HZ defined, but disabling it doesn't help.
I my case timeouts occur in NAND driver, fsl_elbc_nand.c

Felix.
