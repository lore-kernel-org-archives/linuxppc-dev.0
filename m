Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 1CB94DE596
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 00:18:45 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so940421ugf.0
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Jul 2008 07:18:42 -0700 (PDT)
Message-ID: <487225C4.90405@genesi-usa.com>
Date: Mon, 07 Jul 2008 15:18:44 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: MPC52xx generic DMA using bestcomm
References: <4871E487.2020008@matrix-vision.de>	
	<4872104E.6050109@genesi-usa.com>
	<9e4733910807070639k283b1267q34a4c9bbff827b22@mail.gmail.com>
In-Reply-To: <9e4733910807070639k283b1267q34a4c9bbff827b22@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: Andre Schwarz <andre.schwarz@matrix-vision.de>,
	linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Jon Smirl wrote:
> On 7/7/08, Matt Sealey <matt@genesi-usa.com> wrote:
>>
> to do that the samples have to be alternated as they are fed into the
> AC97 stream.  I think the codec can capture that way too but you
> didn't put a transceiver on the S/PDIF line.

OT, but the IDT STAC9766 doesn't support S/PDIF input, only output.

> In my test driver you only get AC97 or S/PDIF. Grant and I are both
> working on i2s drivers, when we get those sorted out it shouldn't be
> too hard to add ac97 back in. That codec driver I sent you was about
> 95% complete.

Indeed and to be honest I only gave it a short glance before having to
do about a thousand other things, but I will take another peek some
time this week :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
