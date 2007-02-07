Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id E6F4CDDEE4
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 09:26:36 +1100 (EST)
Message-ID: <45CA520F.1080006@freescale.com>
Date: Wed, 07 Feb 2007 16:26:23 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH] Update udbg_progress() to display the integer
References: <11707051151024-git-send-email-timur@freescale.com>
	<20070206013051.GA15525@lixom.net> <45C90A6E.3040302@freescale.com>
	<17865.2853.132102.769702@cargo.ozlabs.ibm.com>
	<1170805102.2620.264.camel@localhost.localdomain>
	<0C529499-B766-4D3A-8340-361BB1B461D3@kernel.crashing.org>
	<45C9151E.70201@freescale.com> <20070207000326.GA26024@lixom.net>
	<45C9177B.4050308@freescale.com>
	<20070207215957.GD5616@austin.ibm.com>
In-Reply-To: <20070207215957.GD5616@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:

> The HMC progress display is the "same as" the LED's 
> i.e. one line of 30 or 40 chars. Its enough to tell you 
> the kernel version you've booted, or if the machine is
> stuck in firmware. but that's about it. 

In that case, it looks like we need to keep pcc_md.progress(), but I still think 
it should be restricted to platforms where it outputs to a device other than the 
device that printk() is outputting to.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
