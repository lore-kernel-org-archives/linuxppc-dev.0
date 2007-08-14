Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 61D2CDDF0D
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 06:40:24 +1000 (EST)
Subject: Re: System crash on boot_e500.S
From: Jon Loeliger <jdl@freescale.com>
To: mike zheng <mail4mz@gmail.com>
In-Reply-To: <5c9cd53b0708141314o57440c62waffb4cca3f2be0b9@mail.gmail.com>
References: <5c9cd53b0708141314o57440c62waffb4cca3f2be0b9@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1187124014.32650.80.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 14 Aug 2007 15:40:14 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-08-14 at 15:14, mike zheng wrote:
> Hi All,
>  
> I am trying to bring up MPC8548 CDS board on 2.4 kernel. I have
> problem in the head

Ow, it hurts when I do this!

> _e500.S. The "mtspr SRR0, r7; mtspr SRR1 r6" does not work for me. The
> content of R7 and R6 are not moved to SRR0 and SRR1.  I am using the
> tool-chain from Freescale for 2.6 kernel. 
>  
> Any idea on this issue?

Maybe use current 2.6 code?

jdl
