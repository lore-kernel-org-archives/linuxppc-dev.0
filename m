Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D170DE3A3
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 01:42:36 +1000 (EST)
Message-Id: <FBA9C9D8-03C8-4297-9641-9C733D342F9D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
In-Reply-To: <1222184138-6151-1-git-send-email-jacmet@sunsite.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v5] powerpc: gpio driver for mpc8349/8572/8610 and
	compatible
Date: Tue, 23 Sep 2008 10:42:32 -0500
References: <1222184138-6151-1-git-send-email-jacmet@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 23, 2008, at 10:35 AM, Peter Korsgaard wrote:

> Structured similar to the existing QE GPIO support.
>
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> Changes since v4:
> - Respun against powerpc-next, no functional changes
> - Added Anton's ack
>
> Changes since v3:
> - Incorporated feedback from Anton
>
> Changes since v2:
> - Clarified documentation as requested by Kumar.
>
> Changes since v1:
> Incorporated feedback from Anton and Kumar:
> - Core is also used on 8572/8610 so s/83xx/8xxx/
> - Use fsl,mpc8572-gpio / fsl,mpc8610-gpio for 85xx/86xx as compatible
> - Use shadowed data register to handle open drain outputs
> - Expandend dts binding doc, use 8347 as example instead of 8349
> - Misc small cleanups

applied.

- k
