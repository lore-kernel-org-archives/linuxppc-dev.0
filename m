Return-Path: <gknispel@proformatique.com>
Received: from mx1.corp.avencall.com (mx1.corp.avencall.com [91.194.178.12])
	by ozlabs.org (Postfix) with ESMTP id 937BCB7D80
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 May 2010 23:34:40 +1000 (EST)
Date: Wed, 5 May 2010 15:34:35 +0200
From: Guillaume Knispel <gknispel@proformatique.com>
To: xiaokun <xiaokun@sf-auto.com>
Subject: Re: question about cpm_uart_cpm2.c "Section mismatch in reference
	from the function cpm_uart_allocbuf"
Message-ID: <20100505153435.79711e3d@xilun.lan.proformatique.com>
In-Reply-To: <022701caec44$cd936280$9c1cbcc0@sfdomain.com>
References: <022701caec44$cd936280$9c1cbcc0@sfdomain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 5 May 2010 19:19:18 +0800
xiaokun <xiaokun@sf-auto.com> wrote:

> I am using MPC8272ADS_20080623-ltib.iso from freescale
> 
> The Linux Kernel is 2.6.25.
> 
> When I make uImage, the error message is :
> 
> WARNING: vmlinux.o(.text+0x159450): Section mismatch in reference from the function cpm_uart_allocbuf() to the function .init.text:__alloc_bootmem()
> The function cpm_uart_allocbuf() references
> the function __init __alloc_bootmem().
> This is often because cpm_uart_allocbuf lacks a __init
> annotation or the annotation of __alloc_bootmem is wrong.
> 
> 
> It seems that "drivers\serial\cpm_uart\cpm_uart_cpm2.c" needs to be patched.

arghhhh, the "\" heart my eyes!!! ;)

> How to find the patch?

Maybe do a git log on a recent kernel on this file
(I have not checked the results)

> How to search in  the collection of prior postings to this mail list?

Maybe try something like :
http://www.google.com/#q=site%3Alists.ozlabs.org+cpm_uart_allocbuf
(I have not checked the results)


Cheers!
Guillaume Knispel
