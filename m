Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6EBADB707F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 08:33:15 +1000 (EST)
In-Reply-To: <AANLkTikyNZ5gCpuRPIZ-CJ6ClNZI_UDsmGF7xTzsv9vB@mail.gmail.com>
References: <AANLkTimV1AFEUrRf-2iEizXH4HQFMrrAumsRVDKxNfAv@mail.gmail.com>
	<356261A9-B09F-4E82-A897-FD0724C503F4@kernel.crashing.org>
	<20100630004633.GB12417@yookeroo>
	<AANLkTikyNZ5gCpuRPIZ-CJ6ClNZI_UDsmGF7xTzsv9vB@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <47F80BE0-6596-4A3D-B95F-72ABE2E0228C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: kernel init exception
Date: Thu, 1 Jul 2010 00:31:22 +0200
To: "wilbur.chan" <wilbur512@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Maybe it was caused by floating exception.I found that,system received
> a program check exception,the reason for it was REASON_ILLEGAL.
>
> I also use show_regs to print the NIP in exception,it seemed that
> ,this exception was caused by 'vmhaddshs' instruction in user mode of
> init process .
>
> Is vmhaddshs avaliable on e500mc? My cross compile tool is  
> gcc-4.1.2-glibc-2.5.0

This isn't vmhaddshs (which is an AltiVec instruction), but something  
else
that also uses primary opcode 4.

It sounds like your toolchain isn't set up correctly for e500mc.


Segher
