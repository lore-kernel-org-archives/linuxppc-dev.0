Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC1EBDDFB3
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 07:39:07 +1100 (EST)
Date: Sun, 25 Nov 2007 23:37:50 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH resend 4/4] powerpc: Add support for PORTA and PORTB odr
	registers
Message-ID: <20071125233750.11c1e788@kernel.crashing.org>
In-Reply-To: <4745B435.3080002@scram.de>
References: <4745B435.3080002@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 22 Nov 2007 17:54:13 +0100
Jochen Friedrich wrote:

> PORTA and PORTB have odr registers, as well. However, the PORTB odr
> register is only 16bit.
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> Acked-by: Scott Wood <scottwood@freescale.com>
Applied to linux-2.6-8xx.git,  for-paulus branch
-- 
Sincerely, Vitaly
