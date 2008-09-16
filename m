Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2554DDDE1
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 01:10:11 +1000 (EST)
Message-Id: <A82543C2-D02E-480A-A209-0EEEF181CAFB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <1220472145-1663-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] sbc8560: fix compile warning on CPM pin array
Date: Tue, 16 Sep 2008 10:10:02 -0500
References: <1220472145-1663-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 3, 2008, at 3:02 PM, Paul Gortmaker wrote:

> This is just a parallel of a5dc66e2ab2e2cf641346b056a69a67cfcf9458c
> applied to the sbc8560 board.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/platforms/85xx/sbc8560.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to powerpc-next.

- k
