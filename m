Return-Path: <dan.j.williams@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by ozlabs.org (Postfix) with ESMTP id 29C75DDEE8
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Mar 2007 06:09:32 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so598497nfc
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 12:09:31 -0700 (PDT)
Message-ID: <e9c3a7c20703171209m55fd9dfsbba0e4fff5c6350d@mail.gmail.com>
Date: Sat, 17 Mar 2007 12:09:31 -0700
From: "Dan Williams" <dan.j.williams@gmail.com>
To: "Stefan Roese" <sr@denx.de>
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors.
In-Reply-To: <200703171943.27465.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315232956.37DAB353A6C@atlas.denx.de>
	<200703170909.13869.sr@denx.de>
	<e9c3a7c20703171117w7989adfehda99416265eef906@mail.gmail.com>
	<200703171943.27465.sr@denx.de>
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The current implementation builds on my embedded PPC4xx system without any
> disks the objects async_tx.o and xor.o into the kernel which I definitely
> don't need and want. And I get something like:
>
> async_tx: api initialized (sync-only)
> xor: measuring software checksumming speed
>    8regs     :   145.000 MB/sec
>    8regs_prefetch:   115.000 MB/sec
>    32regs    :   176.000 MB/sec
>    32regs_prefetch:   135.000 MB/sec
> xor: using function: 32regs (176.000 MB/sec)
>
> upon bootup.
Understood I'll change it so that xor.o and async_tx.o are off by default.

>
> Best regards,
> Stefan

Dan
