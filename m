Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19CABDE2D4
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 08:01:23 +1000 (EST)
Message-Id: <057C3E99-B1DC-49BF-B9A8-4C72D943E920@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080610193215.GA14162@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc: 83xx: update mpc83xx_defconfig to support
	MPC8360E-RDK
Date: Tue, 10 Jun 2008 17:01:17 -0500
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190049.GE21203@polina.dev.rtsoft.ru>
	<67EC8BE5-3BF0-4107-8FA9-A058283E7EB5@kernel.crashing.org>
	<20080610193215.GA14162@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 10, 2008, at 2:32 PM, Anton Vorontsov wrote:

> This patch updates mpc83xx_defconfig to support MPC8360E-RDK board.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> On Tue, Jun 10, 2008 at 10:55:39AM -0500, Kumar Gala wrote:
> [...]
>> Can you do me a favor and update mpc83xx_defconfig and make sure that
>> boots and provide that in a separate patch.  I want to start making  
>> sure
>> we have whatever features boards need enabled in the  
>> mpc83xx_defconfig.
>
> Done. This is on top of your current powerpc-next branch (HEAD
> at 917f0af9e5a9ce) + applied patches (seems like you forgot to push
> out the tree).
>
> Thus mpc83xx_defconfig wasn't updated for a long time, so the
> patch isn't readable.
>
> Here is what I enabled manually:

Can you look at refreshing this against my for-2.6.26 tree (its got an  
updated defconfig)

Or update the mpc83xx_defconfig and than enable what you needed and  
provide a patch of just the things being enabled.

- k
