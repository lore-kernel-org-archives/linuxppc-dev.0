Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BED0DDFE6
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 06:44:58 +1100 (EST)
In-Reply-To: <1168968034.31963.11.camel@gentoo-jocke.transmode.se>
References: <1168968034.31963.11.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2020B6C5-0C40-42AF-9ED0-478E11748517@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Warnings when booting rc5 on a mpc83xx based board
Date: Tue, 16 Jan 2007 13:43:57 -0600
To: joakim.tjernlund@transmode.se
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Not seeing this on a 2.6.20-rc5 boot of MPC8349.  Any special config  
options on?

- k

On Jan 16, 2007, at 11:20 AM, Joakim Tjernlund wrote:

> after upgrading to rc5 I get this:
>
> IPIC (128 IRQ sources) at fdefd700
> QEIC (64 IRQ sources) at fdefc080
> PID hash table entries: 512 (order: 9, 2048 bytes)
> ------------[ cut here ]------------
> Badness at c00f4278 [verbose debug info unavailable]
> Call Trace:
> [C0249DC0] [C00085BC] show_stack+0x48/0x194 (unreliable)
> [C0249DF0] [C00F2158] report_bug+0x84/0xac
> [C0249E00] [C000DD28] program_check_exception+0xe0/0x538
> [C0249E40] [C000F78C] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at kref_get+0xc/0x24
>     LR = of_node_get+0x20/0x38
> [C0249F00] [FFFFFFFF] 0xffffffff (unreliable)
> [C0249F10] [C000CCA0] of_find_node_by_type+0x8c/0xd0
> [C0249F30] [C02198A0] get_freq+0x2c/0x80
> [C0249F50] [C021992C] generic_calibrate_decr+0x38/0xdc
> [C0249F70] [C0219E5C] time_init+0x48c/0x530
> [C0249FD0] [C02135F4] start_kernel+0x120/0x250
> [C0249FF0] [00003438] 0x3438
> ------------[ cut here ]------------
> Badness at c00f4278 [verbose debug info unavailable]
> Call Trace:
> [C0249DC0] [C00085BC] show_stack+0x48/0x194 (unreliable)
> [C0249DF0] [C00F2158] report_bug+0x84/0xac
> [C0249E00] [C000DD28] program_check_exception+0xe0/0x538
> [C0249E40] [C000F78C] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at kref_get+0xc/0x24
>     LR = of_node_get+0x20/0x38
> [C0249F00] [C7FFEB94] 0xc7ffeb94 (unreliable)
> [C0249F10] [C000CCA0] of_find_node_by_type+0x8c/0xd0
> [C0249F30] [C02198A0] get_freq+0x2c/0x80
> [C0249F50] [C021999C] generic_calibrate_decr+0xa8/0xdc
> [C0249F70] [C0219E5C] time_init+0x48c/0x530
> [C0249FD0] [C02135F4] start_kernel+0x120/0x250
> [C0249FF0] [00003438] 0x3438
> ------------[ cut here ]------------
> Badness at c00f4278 [verbose debug info unavailable]
> Call Trace:
> [C0249DC0] [C00085BC] show_stack+0x48/0x194 (unreliable)
> [C0249DF0] [C00F2158] report_bug+0x84/0xac
> [C0249E00] [C000DD28] program_check_exception+0xe0/0x538
> [C0249E40] [C000F78C] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at kref_get+0xc/0x24
>     LR = of_node_get+0x20/0x38
> [C0249F00] [C7FFEB94] 0xc7ffeb94 (unreliable)
> [C0249F10] [C000CCA0] of_find_node_by_type+0x8c/0xd0
> [C0249F30] [C02198A0] get_freq+0x2c/0x80
> [C0249F50] [C021996C] generic_calibrate_decr+0x78/0xdc
> [C0249F70] [C0219E5C] time_init+0x48c/0x530
> [C0249FD0] [C02135F4] start_kernel+0x120/0x250
> [C0249FF0] [00003438] 0x3438
> ------------[ cut here ]------------
> Badness at c00f4278 [verbose debug info unavailable]
> Call Trace:
> [C0249DC0] [C00085BC] show_stack+0x48/0x194 (unreliable)
> [C0249DF0] [C00F2158] report_bug+0x84/0xac
> [C0249E00] [C000DD28] program_check_exception+0xe0/0x538
> [C0249E40] [C000F78C] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at kref_get+0xc/0x24
>     LR = of_node_get+0x20/0x38
> [C0249F00] [C7FFEB94] 0xc7ffeb94 (unreliable)
> [C0249F10] [C000CCA0] of_find_node_by_type+0x8c/0xd0
> [C0249F30] [C02198A0] get_freq+0x2c/0x80
> [C0249F50] [C02199B8] generic_calibrate_decr+0xc4/0xdc
> [C0249F70] [C0219E5C] time_init+0x48c/0x530
> [C0249FD0] [C02135F4] start_kernel+0x120/0x250
> [C0249FF0] [00003438] 0x3438
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
>
>
> and this:
>
> Memory: 127272k/131072k available (2252k kernel code, 3636k  
> reserved, 84k data, 95k bs
> s, 128k init)
> Mount-cache hash table entries: 512
> ------------[ cut here ]------------
> Badness at c00f4278 [verbose debug info unavailable]
> Call Trace:
> [C0249E00] [C00085BC] show_stack+0x48/0x194 (unreliable)
> [C0249E30] [C00F2158] report_bug+0x84/0xac
> [C0249E40] [C000DD28] program_check_exception+0xe0/0x538
> [C0249E80] [C000F78C] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at kref_get+0xc/0x24
>     LR = of_node_get+0x20/0x38
> [C0249F40] [C00F2CA8] idr_get_new+0x1c/0x78 (unreliable)
> [C0249F50] [C000CB0C] of_get_next_child+0x34/0x9c
> [C0249F70] [C009556C] proc_device_tree_add_node+0x4c/0x144
> [C0249F90] [C0095560] proc_device_tree_add_node+0x40/0x144
> [C0249FB0] [C00956D8] proc_device_tree_init+0x74/0x90
> [C0249FC0] [C0224630] proc_root_init+0x11c/0x138
> [C0249FD0] [C02136B4] start_kernel+0x1e0/0x250
> [C0249FF0] [00003438] 0x3438
> NET: Registered protocol family 16
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
