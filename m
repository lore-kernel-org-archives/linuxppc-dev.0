Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B128AB716F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 03:53:23 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 395D7DDDD4
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 03:53:21 +1000 (EST)
Message-Id: <71FC3E27-40A6-4212-A4BE-428732D6A624@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
In-Reply-To: <c384c5ea0906170907u5a4af524m65e23b32446dd79f@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: 2.6.30-rc6: Problem with an SSD disk on Freescale PowerPC
	mpc8315e-rdb, works fine on x86
Date: Wed, 17 Jun 2009 12:53:15 -0500
References: <c384c5ea0906080759n24a66d21ob9076518cec41755@mail.gmail.com>
	<c384c5ea0906170907u5a4af524m65e23b32446dd79f@mail.gmail.com>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 17, 2009, at 11:07 AM, Leon Woestenberg wrote:

> Hello Kumar, all,
>
> On Mon, Jun 8, 2009 at 4:59 PM, Leon
> Woestenberg<leon.woestenberg@gmail.com> wrote:
>> using 2.6.30-rc6, I get the following problems when I read from a SSD
>> disk, connected to the
>> 3.0 Gb SATA controller of the MPC8315E SoC rev 1.0 running Linux  
>> 2.6.30-rc6.
>>
> Result on a first batch of bisects. I decided to go with the kernel
> releases rather than git-bisect (still too scary for me).
>
> All kernel releases 2.6.25 through -30 kernel gave the same error.
> 2.6.25 crashed on it, whereas 2.6.26+ recovered after each "dd" run.
>
> The BSP 2.6.24.3-rt3 kernel did not give the error.
>
> So on my todo is diff between 2.6.25 and .2.6.24.3-rt3 from the BSP.

Does kernel.org 2.6.24 work ok?

- k
