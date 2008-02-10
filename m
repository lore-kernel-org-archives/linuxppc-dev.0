Return-Path: <adobriyan@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 2EDBEDDE3B
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 05:00:13 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1562248wag.13
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Feb 2008 10:00:12 -0800 (PST)
Date: Sun, 10 Feb 2008 21:00:03 +0300
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: pci_proc_init: proc_dir_entry '00' already registered
Message-ID: <20080210180003.GC1754@martell.zuzino.mipt.ru>
References: <20080210100757.GA28322@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080210100757.GA28322@aepfle.de>
From: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 10, 2008 at 11:07:57AM +0100, Olaf Hering wrote:
> Current Linus tree gives this new warning during bootup:
> 
> +proc_dir_entry '00' already registered
> +Call Trace:
> +[c00000007b0dfba0] [c00000000000e4b0] .show_stack+0x70/0x1bc (unreliable)
> +[c00000007b0dfc50] [c0000000000f2714] .proc_register+0x130/0x210
> +[c00000007b0dfd00] [c0000000000f299c] .proc_mkdir_mode+0x40/0x70
> +[c00000007b0dfd80] [c000000000276ed8] .pci_proc_attach_device+0xac/0x144
> +[c00000007b0dfe20] [c0000000005bdb3c] .pci_proc_init+0x74/0xac
> +[c00000007b0dfea0] [c0000000005a27ac] .kernel_init+0x1d0/0x394
> +[c00000007b0dff90] [c00000000001e258] .kernel_thread+0x4c/0x68

Can you insert dump_stack() when '00' is registered, not just second
time?
