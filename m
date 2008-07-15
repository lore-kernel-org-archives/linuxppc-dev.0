Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 416D1DE147
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:13:56 +1000 (EST)
Message-Id: <9D3EC444-D4AB-42BD-A873-432F85B20152@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <1215721295-17555-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] mpc7448: add alias list to DTS, clean out old chosen node
Date: Tue, 15 Jul 2008 08:13:51 -0500
References: <1215721295-17555-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 10, 2008, at 3:21 PM, Paul Gortmaker wrote:

> The mpc7448hpc2 board doesn't have an alias block like
> most of the other modern eval boards have.  We need this
> block in order to have u-boot be able to make use of the
> CONFIG_OF_STDOUT_VIA_ALIAS (vs. having a hard coded node)
> in the future.
>
> Also remove the old, redundant chosen node.  Of all the modern
> Freescale eval boards (incl. 83xx, 85xx, 86xx) this is the only
> one which still has it.  Its presence also breaks with some older
> versions of u-boot, like 1.3.1 -- which try and insert a
> second chosen node.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/boot/dts/mpc7448hpc2.dts |   24 +++++++++++++++---------
> 1 files changed, 15 insertions(+), 9 deletions(-)

applied.

- k
