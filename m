Return-Path: <pengxihan@gmail.com>
Received: from mail-pw0-f50.google.com (mail-pw0-f50.google.com
	[209.85.160.50]) by ozlabs.org (Postfix) with ESMTP id 2167AB7BE8
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 11:35:33 +1100 (EST)
Received: by pwi4 with SMTP id 4so2248646pwi.9
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Nov 2009 16:35:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <15E6E326-D17B-42D7-AA22-2CA319C2A808@kernel.crashing.org>
References: <389deec70911020740k13b56bc6kdad3bfaa39916f54@mail.gmail.com>
	<15E6E326-D17B-42D7-AA22-2CA319C2A808@kernel.crashing.org>
Date: Tue, 3 Nov 2009 08:35:32 +0800
Message-ID: <389deec70911021635v6e12a976t9e20fb5f12d8987b@mail.gmail.com>
Subject: Re: mpc8548 does not make use of DMA when doing memory copy?
From: hank peng <pengxihan@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
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

2009/11/3 Kumar Gala <galak@kernel.crashing.org>:
>
> On Nov 2, 2009, at 9:40 AM, hank peng wrote:
>
>> Kernel version is 2.6.30 and I have enabled fsl DMA engine during
>> configuring kernel. After system booted, I have seen only 38 DMA
>> interrupts, and no increase later when I am doing data transfer
>> through network.
>> So I wonder if mpc8548 =C2=A0had made use of DMA engine when doing memcp=
y,
>> or maybe if there are other things I haven't noticed?
>
> The dma engine code is not normally used for normal memcpy's in the kerne=
l.
> =C2=A0There are explicit call sites that have async behavior that should =
use it
> (like the networking code).
>
I remember normal memory copy can also be done (chosen by user) by DMA
engine on IOP80331(Intel embedded cpu, xscale arch), so why ppc
platform didn't make use of DMA doing memory copy, I think it can
increase performance, please correct me if I am wrong!

> - k
>



--=20
The simplest is not all best but the best is surely the simplest!
