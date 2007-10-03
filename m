Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F98FDDEB8
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 01:51:31 +1000 (EST)
In-Reply-To: <87przwxkzf.fsf@macbook.be.48ers.dk>
References: <87przwxkzf.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <085BE1E4-945F-4690-9DFC-627F242831A6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsl_spi devices should use mode "cpu" or "qe"
Date: Wed, 3 Oct 2007 10:51:31 -0500
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2007, at 10:43 AM, Peter Korsgaard wrote:

> According to booting-without-of.txt, fsl_spi mode should be either
> "cpu" or "qe", not "cpu-qe".
>
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

I think we should update the doc instead of the code here. Thoughts?

- k
