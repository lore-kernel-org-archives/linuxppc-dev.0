Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdNRS1PJ5zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 19:09:24 +1000 (AEST)
Date: Mon, 27 Jun 2016 11:04:03 +0200
From: Anatolij Gustschin <agust@denx.de>
To: David Binderman <linuxdev.baldrick@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, dcb314@hotmail.com
Subject: Re: arch/powerpc/platforms/512x/clock-commonclk.c:824: wrong %
 specifier ?
Message-ID: <20160627110403.7f7151d0@crub>
In-Reply-To: <CAMzoamZPL6ZPFq_DA2T2sk=LE+ax3OMP7BgcyjiXz82ro8dMWQ@mail.gmail.com>
References: <CAMzoamZPL6ZPFq_DA2T2sk=LE+ax3OMP7BgcyjiXz82ro8dMWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 27 Jun 2016 08:59:42 +0100
David Binderman linuxdev.baldrick@gmail.com wrote:
...
>linux-4.7-rc5/arch/powerpc/platforms/512x/clock-commonclk.c:824]:
>(warning) %d in format string (no. 1) requires 'int' but the argument
>type is 'size_t {aka unsigned long}'.

mpc512x is 32-bit arch, size_t is unsigned int if you build 32-bit
kernel.

thanks,

Anatolij
