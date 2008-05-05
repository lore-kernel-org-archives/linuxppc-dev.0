Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38348DDED7
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 05:11:42 +1000 (EST)
Message-Id: <EFF7334F-3526-4E2B-8D5C-B97A02BDA71A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080505185607.GB4906@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/2] [POWERPC] 86xx: mpc8610_hpcd: add support for ULI RTC
Date: Mon, 5 May 2008 14:11:30 -0500
References: <20080505185607.GB4906@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 5, 2008, at 1:56 PM, Anton Vorontsov wrote:

> The ULI "Super South Bridge" contains ISA bridge to the legacy
> devices, such as Super IO mouse/keyboard/floppy disk controllers,
> parallel port, i8259 interrupt controller and so on.
>
> On the MPC8610HPCD, i8259 seems to be disabled (mpc8610_hpcd.c
> confirms this), and other peripherals are not traced out.
> So we use only RTC.
>
> This patch also adds ULI quirk to make RTC actually work (this
> quirk differs a bit from the one in the fsl_uli1575.c).

Can we just one quick for both?

- k
