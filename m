Return-Path: <pengxihan@gmail.com>
Received: from mail-px0-f199.google.com (mail-px0-f199.google.com
	[209.85.216.199]) by ozlabs.org (Postfix) with ESMTP id 45605B7BE6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 01:38:47 +1100 (EST)
Received: by pxi37 with SMTP id 37so3858993pxi.15
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Nov 2009 06:38:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4AEFEC64.3070608@neli.hopto.org>
References: <389deec70911020740k13b56bc6kdad3bfaa39916f54@mail.gmail.com>
	<15E6E326-D17B-42D7-AA22-2CA319C2A808@kernel.crashing.org>
	<389deec70911021635v6e12a976t9e20fb5f12d8987b@mail.gmail.com>
	<4AEFEC64.3070608@neli.hopto.org>
Date: Tue, 3 Nov 2009 22:38:46 +0800
Message-ID: <389deec70911030638g4a90dae7hd5a164e3d2bd178f@mail.gmail.com>
Subject: Re: mpc8548 does not make use of DMA when doing memory copy?
From: hank peng <pengxihan@gmail.com>
To: Micha Nelissen <micha@neli.hopto.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/11/3 Micha Nelissen <micha@neli.hopto.org>:
> hank peng wrote:
>>
>> I remember normal memory copy can also be done (chosen by user) by DMA
>> engine on IOP80331(Intel embedded cpu, xscale arch), so why ppc
>> platform didn't make use of DMA doing memory copy, I think it can
>> increase performance, please correct me if I am wrong!
>
> AFAIK the DMA engine has only an asynchronous mode (not very smart IMHO).
> This means you always have the overhead of context switch + interrupt +
> context switch, so the transfer has to be quite large for this to pay off.
>
but if the amount of data I want to copy is big enough? can we benefit
from using DMA in such case?
> Micha
>



-- 
The simplest is not all best but the best is surely the simplest!
