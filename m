Return-Path: <wilbur512@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 19851B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 00:35:41 +1000 (EST)
Received: by gyd10 with SMTP id 10so457315gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Jun 2010 07:35:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100630004633.GB12417@yookeroo>
References: <AANLkTimV1AFEUrRf-2iEizXH4HQFMrrAumsRVDKxNfAv@mail.gmail.com>
	<356261A9-B09F-4E82-A897-FD0724C503F4@kernel.crashing.org>
	<20100630004633.GB12417@yookeroo>
Date: Wed, 30 Jun 2010 22:35:39 +0800
Message-ID: <AANLkTikyNZ5gCpuRPIZ-CJ6ClNZI_UDsmGF7xTzsv9vB@mail.gmail.com>
Subject: Re: kernel init exception
From: "wilbur.chan" <wilbur512@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, David, Segher,


Maybe it was caused by floating exception.I found that,system received
a program check exception,the reason for it was REASON_ILLEGAL.

I also use show_regs to print the NIP in exception,it seemed that
,this exception was caused by 'vmhaddshs' instruction in user mode of
init process .

Is vmhaddshs avaliable on e500mc? My cross compile tool is gcc-4.1.2-glibc-2.5.0
